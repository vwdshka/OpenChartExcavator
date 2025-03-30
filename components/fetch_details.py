from selenium.webdriver.common.by import By


def fetch_details_function(maps_item):
    detail_div = maps_item.find_elements(By.CSS_SELECTOR, ".fontBodyMedium")[-1]
    details = []
    tag_elements = detail_div.find_elements(By.CSS_SELECTOR, "span[style]")
    for tag_element in tag_elements:
        details.append(tag_element.text)

    print(details)