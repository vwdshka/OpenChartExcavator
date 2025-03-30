from selenium.webdriver.common.by import By

def fetch_title_function(maps_item):
    title_element = maps_item.find_element(By.CSS_SELECTOR, "div.fontHeadlineSmall")
    title = title_element.text
    print(title)