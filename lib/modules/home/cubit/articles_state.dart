import 'package:flutter/material.dart';
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/source.dart';

@immutable
sealed class ArticlesState {}

final class LoadingArticlesState extends ArticlesState {}

final class SourcesLoadedState extends ArticlesState {
  final List<SourceData> sourcesList;

  SourcesLoadedState({required this.sourcesList});
}

final class ArticlesLoadedState extends ArticlesState {
  final List<ArticleData> articlesList;

  ArticlesLoadedState({required this.articlesList});
}