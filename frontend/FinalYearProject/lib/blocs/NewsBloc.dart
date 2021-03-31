import 'dart:async';
import 'package:FinalYearProject/models/NewsModel.dart';
import 'package:FinalYearProject/networking/Response.dart';
import 'package:FinalYearProject/repository/NewsRepository.dart';

class NewsBloc {
  NewsRepository _newsRepository;
  StreamController _newsController;

  StreamSink<Response<NewsModel>> get newsDataSink => _newsController.sink;

  Stream<Response<NewsModel>> get newsDataStream => _newsController.stream;

  NewsBloc() {
    _newsController = StreamController<Response<NewsModel>>();
    _newsRepository = NewsRepository();
    fetchNews();
  }

  fetchNews() async {
    newsDataSink.add(Response.loading('Fetching todays news!'));
    try {
      NewsModel dealsDetails = await _newsRepository.getNews();
      newsDataSink.add(Response.completed(dealsDetails));
    } catch (e) {
      newsDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _newsController?.close();
  }
}
