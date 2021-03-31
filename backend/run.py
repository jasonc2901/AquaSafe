from app import api_bp
from flask import Flask
from resources import bbc_news_webscaper as bbc
from resources import nytimes_webscrape as nyt
from resources import epa_news_webscraper as epa

import json

water_pollution_app = Flask(__name__)

water_pollution_app.register_blueprint(api_bp, url_prefix='/api')


if __name__ == "__main__":
    water_pollution_app.run(debug=True)
