import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Newsprovider with ChangeNotifier {
  final List<News> _news = [];
  List<News> _favNews = [];
  Future getNews() async {
    var url = Uri.parse('https://api.first.org/data/v1/news/');
    final response = await http.get(url);

    final encrepted = jsonDecode(response.body) as Map<String, dynamic>;
    //print(encrepted);

    for (var i = 0; i < encrepted['data'].length; i++) {
      _news.add(
        News(
            id: encrepted['data'][i]['id'],
            title: encrepted['data'][i]['title'],
            //summary: encrepted['data'][i]['summary'],
            link: encrepted['data'][i]['link'],
            published: encrepted['data'][i]['published']),
      );
    }
    notifyListeners();
    //print(news);
  }

  List<News> get news => _news;
  List<News> get favNews => _favNews;

  void isfavchange(int index) {
    _news.elementAt(index).fav = !_news.elementAt(index).fav;
    if (_news.elementAt(index).fav == true) {
      _favNews.add(_news.elementAt(index));
    }
    notifyListeners();
  }

  void removefav(int index) {
    _favNews.removeAt(index);
    notifyListeners();
  }
}

class News {
  int id;
  String title;
  //String summary;
  String link;
  String published;
  bool fav;

  News({
    required this.id,
    required this.title,
    //required this.summary,
    required this.link,
    required this.published,
    this.fav = false,
  });
}
