from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC



def load_page_function(driver=None, delay=None, bodyXPath=None):
    try:
        bodyElement = WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.XPATH, bodyXPath)))
        print(" ")
    except:
        print(" ")