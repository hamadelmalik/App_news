import 'package:flutter/cupertino.dart';
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/network/api_services.dart';

class ArticlesViewModel extends ChangeNotifier {
  /// hold and prepare data to view
  List<ArticleData> _filteredArticles = [];
  bool _isLoadingSources = true;
  bool _isLoadingArticles = true;
  int _selectedIndex = 0;
  List<SourceData> _sourcesList = [];
  List<ArticleData> _articlesList = [];

  bool get isLoadingSources => _isLoadingSources;

  bool get isLoadingArticles => _isLoadingArticles;

  int get selectedIndex => _selectedIndex;
  List<ArticleData> get filteredArticles => _filteredArticles;


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
      _filteredArticles = _articlesList;
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
  void searchArticles(String keyword) {
    if (keyword.isEmpty) {
      _filteredArticles = _articlesList;
    } else {
      final input = keyword.toString().toLowerCase();

      _filteredArticles = _articlesList.where((article) {
        final title = article.title.toString().toLowerCase();
        return title.startsWith(input);
      }).toList();

      if (_filteredArticles.isEmpty) {
        _filteredArticles = _articlesList.where((article) {
          final title = article.title.toString().toLowerCase();
          return title.contains(input);
        }).toList();
      }
    }

    notifyListeners();
  }
}
