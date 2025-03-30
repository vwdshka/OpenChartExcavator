from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def fetch_image_function(maps_item, d):
    img_element = WebDriverWait(d, 5).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, "img[decoding=\"async\"][aria-hidden=\"true\"]"))
    )
    image = img_element.get_attribute("src")