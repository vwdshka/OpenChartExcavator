from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def fetch_link_function(maps_item, link_count=None):
    try:
        link_element = WebDriverWait(maps_item, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "a[jsaction][jslog]"))
        )
        url = link_element.get_attribute("href")
        print(url) # prints the url. remove when ready to store data separately
    except Exception as e:
        print(f"Error locating link: {e}")


# Inconsistency notice:
# Due to the Google services detecting the scraping traffic on their website they try to block some of the CSS elements from loading.
# This results in 124 links passing out of total 126 links -> 98.4126984% passing, the other 1,5873016% cannot be scrapped. ill kms