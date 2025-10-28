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
  List<ArticleData> _allArticlesList = []; // ✅ الأصلية
  List<ArticleData> _filteredList = [];    // ✅ المعروضة بعد الفلترة

  bool get isLoadingSources => _isLoadingSources;
  bool get isLoadingArticles => _isLoadingArticles;
  int get selectedIndex => _selectedIndex;

  List<SourceData> get sourcesList => _sourcesList;
  List<ArticleData> get filteredList => _filteredList; // getter الجديد

  Future<void> getAllSources(String categoryID) async {
    try {
      emit(LoadingArticlesState());
      _isLoadingSources = true;
      _sourcesList = await APIServices.getAllSources(categoryID);
      _isLoadingSources = false;

      if (_sourcesList.isNotEmpty) {
        await getAllArticles(_sourcesList[_selectedIndex].sourceId);
      }

      emit(SourcesLoadedState(sourcesList: _sourcesList));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getAllArticles(String sourceID) async {
    try {
      _isLoadingArticles = true;
      emit(LoadingArticlesState());

      _allArticlesList = await APIServices.getAllArticles(sourceID);
      _filteredList = List.from(_allArticlesList); // نسخ المقالات كلها

      _isLoadingArticles = false;
      emit(ArticlesLoadedState(articlesList: _filteredList));
    } catch (error) {
      rethrow;
    }
  }

  void changeTabIndex(int index) {
    _selectedIndex = index;
    getAllArticles(_sourcesList[_selectedIndex].sourceId);
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

  /// 🔍 البحث باستخدام filteredList
  void searchArticles(String query) {
    if (query.isEmpty) {
      _filteredList = List.from(_allArticlesList);
    } else {
      _filteredList = _allArticlesList.where((article) {
        final title = article.title.toLowerCase();
        final source = article.source.sourceName.toLowerCase();
        return title.startsWith(query.toLowerCase()) ||
            source.startsWith(query.toLowerCase());
      }).toList();
    }

    emit(ArticlesLoadedState(articlesList: _filteredList));
  }
}
