import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_headline/models/Arynewsmodel.dart';
import 'package:news_headline/models/CategoriesNewsModel.dart';
import 'package:news_headline/models/NewsChannelsHeadlinesModel.dart';

class NewsRipository {
  Future<NewsChannelsHeadlinesModel> fetchnewsChannelHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c1a2d158c25f4a8a8ad72cec2263ea48';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future<CategoriesNewsModel> fetchCatagoriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=c1a2d158c25f4a8a8ad72cec2263ea48';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('error');
  }
}
