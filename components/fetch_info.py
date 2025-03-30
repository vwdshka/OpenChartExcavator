from selenium.webdriver.common.by import By


def fetch_info_function(maps_item):
    info_div = maps_item.find_element(By.CSS_SELECTOR, ".fontBodyMedium")
    info = []
    # select all <span> elements with no attributes or the @style attribute
    # and descendant of a <span>
    span_elements = info_div.find_elements(By.XPATH, ".//span[not(@*) or @style][not(descendant::span)]")
    for span_element in span_elements:
        info.append(span_element.text.replace("⋅", "").strip())

    # to remove any duplicate info and empty strings
    info = list(filter(None, list(set(info))))

    print(info)  # Added print statement to display the extracted information