from flask import request, jsonify
from flask_restful import Resource
import json
import resources.nytimes_webscrape as nytimes
import resources.bbc_news_webscaper as bbcnews
import resources.epa_news_webscraper as epanews


class newsResource(Resource):

    def get(self):
        news_articles = nytimes.get_articles()
        bbc_articles = bbcnews.get_articles()
        epa_articles = epanews.get_articles()

        json_response = {
            "articles": news_articles,
            "bbc_articles": bbc_articles,
            "epa_articles": epa_articles
        }

        return {'status': 200, 'data': json_response}
