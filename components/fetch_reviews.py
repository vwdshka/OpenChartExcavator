from selenium.common import NoSuchElementException
from selenium.webdriver.common.by import By
import re

def fetch_reviews_function(maps_item=None):
    try:
        reviews_element = maps_item.find_element(By.CSS_SELECTOR, "span[role=\"img\"]")
        reviews_string = reviews_element.get_attribute("aria-label")

        reviews_string_pattern = r"(\d+\.\d+) stars (\d+[,]*\d+) Reviews"
        reviews_string_match = re.match(reviews_string_pattern, reviews_string)

        if reviews_string_match:
            # Convert stars to float
            reviews_stars = float(reviews_string_match.group(1))
            # Convert reviews count to integer
            reviews_count = int(reviews_string_match.group(2).replace(",", ""))
        else:
            reviews_stars, reviews_count = None, None

        # Print the extracted values
        print(f"Stars: {reviews_stars}, Reviews: {reviews_count}")

        # Return the extracted values as a dictionary
        return {
            "stars": reviews_stars,
            "reviews_count": reviews_count
        }

    except NoSuchElementException:
        print("No review data found.")
        return None

# Won't print out reviews for some reason.