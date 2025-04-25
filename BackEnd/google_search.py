from selenium import webdriver
from selenium.webdriver.common.by import By
import requests
from bs4 import BeautifulSoup
import time
import google.generativeai as genai

# Gemini setup
genai.configure(api_key="AIzaSyBgFAt-xP3T9qxOVyrfQL37jQv1XuEVsi4")
model = genai.GenerativeModel(
    model_name="gemini-1.5-pro-002",
    system_instruction="""
    You are a model that specializes in consuming the information fed to you, breaking it into clear, concise points, 
    and applying external context even if it's not explicitly mentioned in the paragraph. 
    Always structure the response in bullet points for clarity.
    """
)

def chat_with_gemini(text_block):
    response = model.generate_content("User: " + text_block)
    return response.text

# STEP 1: Get article URLs from Google News
def get_article_links(query, num_articles=3):
    driver = webdriver.Chrome()
    links = []
    try:
        driver.get(f"https://news.google.com/search?q={query.replace(' ', '+')}")
        time.sleep(3)

        # Locate articles and filter for external links
        articles = driver.find_elements(By.CSS_SELECTOR, "article")[:num_articles]

        for article in articles:
            try:
                # Use the anchor with 'href' and go up to anchor with full redirect
                a_tag = article.find_element(By.CSS_SELECTOR, 'a')
                link = a_tag.get_attribute("href")

                # Go into that link to get actual publisher link
                if link and "articles" not in link:
                    a_tag.click()
                    time.sleep(2)

                    # Switch to new tab opened
                    driver.switch_to.window(driver.window_handles[-1])
                    real_url = driver.current_url
                    links.append(real_url)

                    driver.close()
                    driver.switch_to.window(driver.window_handles[0])
            except Exception as e:
                print(f"⚠️ Error fetching link: {e}")
                continue
        return links
    finally:
        driver.quit()


# STEP 2: Visit each article URL and scrape paragraphs with BeautifulSoup
def extract_article_text(url):
    try:
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        }
        res = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(res.text, 'html.parser')

        # Scrape <p> tags
        paragraphs = [p.text.strip() for p in soup.find_all('p') if p.text.strip()]
        return "\n".join(paragraphs[:10])  
    except:
        return ""

query = input("Enter search topic: ")
article_urls = get_article_links(query)

all_content = ""
for idx, url in enumerate(article_urls, 1):
    print(f"🔗 Article {idx}: {url}")
    content = extract_article_text(url)
    if content:
        print(f"✅ Got content from Article {idx}")
        all_content += content + "\n\n"
    else:
        print(f"❌ Failed to fetch content from Article {idx}")

# Summarize using Gemini
if all_content.strip():
    print("\n🧠 Gemini's Summary:")
    print(chat_with_gemini(all_content))
else:
    print("No content found to summarize.")
