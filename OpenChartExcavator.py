import time

from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

from components import gm_elements
from components.fetch_details import fetch_details_function
from components.fetch_image import fetch_image_function
from components.fetch_info import fetch_info_function
from components.fetch_link import fetch_link_function
from components.fetch_title import fetch_title_function
from components.wait_for_page_load import load_page_function
from components.fetch_reviews import fetch_reviews_function

# FOR DEPLOYMENT
options = webdriver.ChromeOptions()
options.add_argument('--headless')
driver = webdriver.Chrome(options)

# TESTING ONLY:
# driver = webdriver.Firefox()

myUrl = 'https://www.google.com/maps?ucbcb=1'
driver.get(myUrl)

driver.maximize_window()

driver.implicitly_wait(1)

inputFieldID = 'searchbox'

inputFieldXPath = "//input[@id='searchboxinput']"

driver.find_element(By.XPATH, inputFieldXPath).click()
driver.find_element(By.XPATH, inputFieldXPath).send_keys(gm_elements.search_query_function())
driver.find_element(By.XPATH, inputFieldXPath).send_keys(Keys.ENTER)

bodyXPath = "/html/body/div[1]/div[3]/div[8]/div[9]/div/div/div[1]/div[2]/div/div[1]/div/div/div[1]/div[1]"

load_page_function(driver, delay=2, bodyXPath=bodyXPath)
body = driver.find_element(By.XPATH, "/html/body/div[1]/div[3]/div[8]/div[9]/div/div/div[1]/div[2]/div/div[1]/div/div/div[1]/div[1]")

loop_delay = 0.250
i = 1

while i <= 125:
    body.send_keys(Keys.PAGE_DOWN)
    time.sleep(loop_delay)
    i += 1

# Driver waits for three seconds to reassure that the page is fully loaded before running the scripts.
# Ideal for users with slower bandwidth.

driver.implicitly_wait(3)

maps_items = WebDriverWait(driver, 10).until(
    EC.presence_of_all_elements_located((By.XPATH, '//div[@role="feed"]//div[contains(@jsaction, "mouseover:pane")]'))
)

for maps_item in maps_items:

    fetch_link_function(maps_item)

    fetch_title_function(maps_item)

    # fetch_reviews_function(maps_item)

    fetch_info_function(maps_item)

    fetch_details_function(maps_item)

    fetch_image_function(maps_item, driver)


driver.quit()

# todo introduce saving the extracted information into a separate file/database
