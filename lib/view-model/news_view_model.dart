import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:news_headline/models/Arynewsmodel.dart';
import 'package:news_headline/models/CategoriesNewsModel.dart';
import 'package:news_headline/models/NewsChannelsHeadlinesModel.dart';
import 'package:news_headline/ripository/news_ripository.dart';

class NewsViewModel {
  final _rep = NewsRipository();

  Future<NewsChannelsHeadlinesModel> fetchnewsChannelHeadlinesApi(
      bbcnews) async {
    final Response = await _rep.fetchnewsChannelHeadlinesApi();
    return Response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final Response = await _rep.fetchCatagoriesNewsApi(category);
    return Response;
  }
}
