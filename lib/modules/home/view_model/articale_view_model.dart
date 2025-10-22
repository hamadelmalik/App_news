import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:news_app/models/articale_data.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/network/api_services.dart';

class ArticlesViewModel extends ChangeNotifier {
  /// hold and prepare data to view

  bool _isLoadingSources = true;
  bool _isLoadingArticles = true;
  int _selectedIndex = 0;
  List<SourceData> _sourcesList = [];
  List<ArticleData> _articlesList = [];

  bool get isLoadingSources => _isLoadingSources;

  bool get isLoadingArticles => _isLoadingArticles;

  int get selectedIndex => _selectedIndex;

  List<SourceData> get sourcesList => _sourcesList;

  List<ArticleData> get articlesList => _articlesList;

  Future<void> getAllSources(String categoryID) async {
    try {
      _sourcesList = await APIServices.getAllSources(categoryID);
      changeLoadingSourcesState(false);
      getAllArticles(_sourcesList[_selectedIndex].sourceId);
    } catch (error) {
      throw Exception();
    }

    notifyListeners();
  }

  Future<void> getAllArticles(String sourceID) async {
    try {
      _articlesList = await APIServices.getAllArticles(sourceID);
      changeLoadingArticlesState(false);
    } catch (error) {
      throw Exception();
    }

    notifyListeners();
  }

  void changeTabIndex(int index) {
    _selectedIndex = index;
    getAllArticles(_sourcesList[_selectedIndex].sourceId);
    notifyListeners();
  }

  void changeLoadingSourcesState(bool value) {
    _isLoadingSources = value;
    notifyListeners();
  }

  void changeLoadingArticlesState(bool value) {
    _isLoadingArticles = value;
    notifyListeners();
  }
  List<ArticleData> searchArticles(String keyword) {
    if (keyword.isEmpty) return _articlesList;

    final lowerKeyword = keyword.toLowerCase();

    return _articlesList.where((article) {
      return article.title.toLowerCase().contains(lowerKeyword) ||
          article.description.toLowerCase().contains(lowerKeyword) ||
          article.source.sourceName.toLowerCase().startsWith(lowerKeyword);
    }).toList();
  }

}