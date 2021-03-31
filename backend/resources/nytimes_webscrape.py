from bs4 import BeautifulSoup
import requests

def get_articles():
    # URL for https://www.nytimes.com/topic/subject/water-pollution website
    url = "https://www.nytimes.com/topic/subject/water-pollution"

    # Create a reponse and turn this into HTML code in order to scrape.
    response = requests.get(url)
    content = response.content

    # Create the BeautifulSoup object
    soup = BeautifulSoup(content, "lxml")

    # Get a list of all the articles
    all_articles = soup.find_all("li", class_="css-ye6x8s")

    # Get all the titles of the articles published on the website
    titles = [title.find("h2", class_="css-1j9dxys e1xfvim30").text for title in all_articles]

    # Get all the descriptions of the articles published on the website
    descriptions = [desc.find("p", class_="css-1echdzn e1xfvim31").text for desc in all_articles]

    # Get all the authors of the articles published on the website
    authors = ["Unknown Author" if auth.find("p", class_="css-1xonkmu") is None else auth.find("p", class_="css-1xonkmu").text for auth in all_articles]

    # Get all the images URL's of the articles published on the website
    images = soup.find_all("img")
    image = ["" if img.get("src") is None else img.get("src") for img in images]

    all_urls = soup.find_all("div", class_="css-1l4spti")
    urls = ["" if url.find("a")['href'] is None else url.find("a")['href'] for url in all_urls]

    list_url = []
    for url in urls:
        url = "https://www.nytimes.com" + url
        list_url.append(url)

    # Creates a list to store the article objects
    returned_articles = []

    # Loops through all data using the zip function and creates an article object
    for title, description, auth, img, url in zip(titles, descriptions, authors, image, list_url):
        auth_len = len(auth)
        desc_len = len(description)
        title_len = len(title)
        if auth_len > 25:
            auth = auth[:25] + '...'
        if desc_len > 70:
            description = description[:70] + "..."
        if title_len > 55:
            title = title[:55] + "..."   

        # Creates an object to store the article
        article_object = {
            "Title": title,
            "Description": description,
            "Author": auth, 
            "img_url": img,
            "site_link": url
        }

        returned_articles.append(article_object)

    return returned_articles