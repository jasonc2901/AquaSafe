from bs4 import BeautifulSoup
import requests

# URL for https://www.bbc.co.uk/search?q=Water%20pollution website
def get_articles():
    url = "https://www.bbc.co.uk/news/topics/cnegp3jd4e4t/water-pollution"

    # Create a reponse and turn this into HTML code in order to scrape.
    response = requests.get(url)
    content = response.content

    # Create the BeautifulSoup object
    soup = BeautifulSoup(content, "lxml")

    # Get a list of all the articles
    all_articles = soup.find_all("article", class_="qa-post gs-u-pb-alt+ lx-stream-post gs-u-pt-alt+ gs-u-align-left")

    # Get all the titles of the articles published on the website
    titles = [title.find(
        "div", class_="gs-o-media__body").text for title in all_articles]

    # # Get all the site URL's of the articles published on the website
    urls = ["" if url.find("a")["href"] is None else url.find("a")[
        "href"] for url in all_articles]
    updated_urls = ["https://www.bbc.co.uk" + url for url in urls]
    print(updated_urls)

    # # Get all the image URL's of the articles published on the website
    all_images = soup.find_all("img", class_="qa-srcset-image lx-stream-related-story--index-image qa-story-image")
    image = ["" if img.get("src") is None else img.get("src")
             for img in all_images]
    # Get Descriptions of the articles being published
    descriptions = ["" if desc.find("p", class_="lx-stream-related-story--summary qa-story-summary") is None else desc.find(
        "p", class_="lx-stream-related-story--summary qa-story-summary").text for desc in all_articles]

    # # Get additional details about the article such as the date it has been published
    dates = [date.find(
        "span", class_="qa-post-auto-meta").text for date in all_articles]
    new_dates = [date.replace('duration', '') for date in dates]

    # Creates a list to store the article objects
    returned_articles = []

    # Loops through all data using the zip function and creates an article object
    for title, description, date, img, url in zip(titles, descriptions, new_dates, image, updated_urls):
        cut_desc = len(description)
        bad_image = "https://ichef.bbci.co.uk/images/ic/240x135/p090fw57.jpg"
        if cut_desc > 70:
            description = description[:70] + "..."
        if bad_image:
            # If article has a bad image, replace it
            img = img.replace("https://ichef.bbci.co.uk/images/ic/240x135/p090fw57.jpg", "")
        # Creates an object to store the article
        article_object = {
            "Title": title,
            "Description": description,
            "Date": date,
            "img_url": img,
            "site_link": url
        }
        returned_articles.append(article_object)
        
    return returned_articles
get_articles()