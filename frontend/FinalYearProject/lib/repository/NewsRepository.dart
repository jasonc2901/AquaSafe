import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/NewsModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/articles";

class NewsRepository {
  Future<NewsModel> getNews() async {
    final response = await http.get(url);
    var json = jsonDecode(response.body);

    var newsJson = NewsModel.fromJson(json);

    return newsJson;
  }
}
