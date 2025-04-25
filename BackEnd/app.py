from flask import Flask, request, jsonify
from serpapi import GoogleSearch
from bs4 import BeautifulSoup
import requests
import google.generativeai as genai  # Gemini SDK
from selenium import webdriver
import time
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException, WebDriverException
import random


app = Flask(__name__)

# Initialize Gemini with the correct configuration
genai.configure(api_key="AIzaSyBgFAt-xP3T9qxOVyrfQL37jQv1XuEVsi4")  # Gemini API key

# Create a model with the system instruction
model = genai.GenerativeModel(
    model_name="gemini-1.5-pro-002",
    system_instruction="""You are a financial advisor specializing in Indian investment options. 
Always provide information on Indian government schemes, mutual funds, insurance plans, fixed deposits, 
PPF, EPF, stock market investments, tax-saving options, and related topics. 
If a user asks about global investments, redirect them to Indian alternatives.
"""

def get_article_links(query):
    params = {
        "engine": "google_news",
        "q": query,
        "api_key": "d6d3dbbe99e59eed5c57467fc87c92078cd0b7050b8590fd36a7a08b525078a2",  # SerpAPI Key
        "hl": "en",
        "gl": "us",
    }
    search = GoogleSearch(params)
    results = search.get_dict()
    
    links = []
    for article in results.get('news_results', []):
        if 'link' in article: 
            links.append(article['link'])

    return links

def get_article_content(url):
    chrome_options = Options()
    chrome_options.add_argument("--headless")  # Run headless (no GUI)
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")

    driver = webdriver.Chrome(options=chrome_options)

    try:
        driver.set_page_load_timeout(10)  # 10 seconds max load time

        try:
            driver.get(url)
        except (TimeoutException, WebDriverException) as e:
            print(f"[WARN] Initial load failed for {url}: {e}")
            # Try ONE more time
            try:
                driver.get(url)
            except Exception as e2:
                print(f"[ERROR] Retry load failed for {url}: {e2}")
                driver.quit()
                return {"title": "Load Failed", "text": ""}

        time.sleep(2)  # Optional: wait a little for JS to load

        html = driver.page_source
        soup = BeautifulSoup(html, 'html.parser')

        paragraphs = soup.find_all('p')
        article_paragraphs = []

        for p in paragraphs:
            text = p.get_text().strip()
            if len(text) > 40:
                article_paragraphs.append(text)

        article_text = "\n\n".join(article_paragraphs)

        title_tag = soup.find('title')
        title = title_tag.text if title_tag else "No Title Found"

    except Exception as e:
        print(f"[FATAL] Failed scraping {url}: {e}")
        article_text = ""
        title = "Error Fetching Article"

    finally:
        driver.quit()

    return {
        "title": title,
        "text": article_text
    }



def summarize_text(text):
    # Use the updated model with the new configuration
    response = model.generate_content(f"Summarize the following article:\n\n{text}")
    return response.text

@app.route('/ask', methods=['POST'])
def summarize_articles():
    data = request.json
    query = data.get("query")

    if not query:
        return jsonify({"error": "Missing query parameter"}), 400

    try:
        article_urls = get_article_links(query)
        summaries = []

        for url in article_urls:
            try:
                article_data = get_article_content(url)
                if len(article_data['text']) == 0:
                    print(f"Skipping short or empty article: {url}")
                    continue
                summary = summarize_text(article_data['text'])
                summaries.append({
                "title": article_data['title'],
                "url": url,
                "summary": summary
                })
            except Exception as e:
                print(f"Error scraping {url}: {e}")



        return jsonify({"summaries": summaries})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
