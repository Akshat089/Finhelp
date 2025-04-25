from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time


driver = webdriver.Chrome()
driver.get("https://www.india.gov.in/my-government/documents")
time.sleep(5)  
try:
    elem = driver.find_element(By.NAME, "s")  
except:
    print("Search box not found!")
    driver.quit()
    exit()

elem.clear()
elem.send_keys("mutual fund schemes")
elem.send_keys(Keys.RETURN)
time.sleep(10)
# driver.quit()
articles_list = []
articles = driver.find_elements(By.CLASS_NAME, "gs-title")
for article in articles:
    try:
        title = article.text  # Get article title
        link = article.get_attribute("href")  # Get article URL
        if link: 
            articles_list.append(link)
    except:
        continue
for art in articles_list:
    driver.get(art)
    time.sleep(3)
    continue
