from bs4 import BeautifulSoup
import requests

# def get_articles():
# URL for https://www.catchments.ie/news/ website


def get_articles():
    url = "https://www.catchments.ie/news/"

    # Create a reponse and turn this into HTML code in order to scrape.
    response = requests.get(url)
    content = response.content

    # Create the BeautifulSoup object
    soup = BeautifulSoup(content, "lxml")

    # Get a list of all the articles
    all_articles = soup.find_all(
        "div", class_="col-xs-12 col-sm-6 masonry-grid-item")

    # Get all the site URL's of the articles published on the website
    urls = ["" if url.find("a")["href"] is None else url.find("a")[
        "href"] for url in all_articles]

    # Get all the image URL's of the articles published on the website
    all_images = soup.find_all("img", class_="bg-image wp-post-image")
    image = ["" if img.get("src") is None else img.get("src")
             for img in all_images]

    dates = ["" if date.find("span", class_="post-date") is None else date.find(
        "span", class_="post-date").text for date in all_articles]
    tidy_dates = []
    for date in dates:
        replace = date.replace("\n", '')
        tidy_dates.append(replace)

    # Get all the titles of the articles published on the website
    titles = [title.find(
        "h3", class_="post-title").text for title in all_articles]

    # Get Descriptions of the articles being published
    all_desciptions = soup.find_all("p", class_=None)

    # descriptions = ["" if desc.find("p", class_=None) is None else desc.find("p", class_=None).text for desc in all_articles]

    # Creates a list to store the article objects
    returned_articles = []

    # Loops through all data using the zip function and creates an article object
    for title, description, date, img, url in zip(titles, all_desciptions, tidy_dates, image, urls):
        desc_len = len(description)
        title_len = len(title)

        if title_len > 20:
            title = title[:20] + "..."

        if desc_len > 90:
            description = description[:90] + "..."
        # Creates an object to store the article
        article_object = {
            "Title": title,
            "Date": date,
            "img_url": img,
            "site_link": url
        }
        returned_articles.append(article_object)

    return returned_articles
