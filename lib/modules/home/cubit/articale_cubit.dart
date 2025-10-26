import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/modules/home/cubit/articles_state.dart';
import 'package:news_app/network/api_services.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(LoadingArticlesState());

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
      emit(LoadingArticlesState());
      _sourcesList = await APIServices.getAllSources(categoryID);
      changeLoadingSourcesState(false);
      getAllArticles(_sourcesList[_selectedIndex].sourceId);
    } catch (error) {
      throw Exception();
    }

    emit(SourcesLoadedState(sourcesList: _sourcesList));
  }

  Future<void> getAllArticles(String sourceID) async {
    try {
      _articlesList = await APIServices.getAllArticles(sourceID);
      changeLoadingArticlesState(false);
    } catch (error) {
      throw Exception();
    }

    emit(ArticlesLoadedState(articlesList: _articlesList));
  }

  void changeTabIndex(int index) {
    _selectedIndex = index;
    getAllArticles(_sourcesList[_selectedIndex].sourceId);
  }

  void changeLoadingSourcesState(bool value) {
    _isLoadingSources = value;
  }

  void changeLoadingArticlesState(bool value) {
    _isLoadingArticles = value;
  }
  String timeAgo(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(dateString);
      return timeago.format(dateTime, locale: 'en');
    } catch (e) {
      return dateString;
    }
  }

}