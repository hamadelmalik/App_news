

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/network/api_constants.dart';
import 'package:news_app/network/end_point.dart';

class APIServices {
  static Future<List<SourceData>> getAllSources(String categoryID) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "apiKey": APIConstants.apiKey,
        "category": categoryID,
      };

      final response = await http.get(
        Uri.https(APIConstants.baseURl, EndPoints.sources, queryParameters),
      );

      List<SourceData> sourcesList = [];

      if (response.statusCode == 200) {
        // logic Json as String
        // 1- convert to Json
        // 2- convert to List of SourceData

        var data = jsonDecode(response.body);
        for (var element in data["sources"]) {
          var dataObject = SourceData.formJson(element);
          sourcesList.add(dataObject);
        }
        log(sourcesList.toString());
      }
      log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      log("API Response: ${response.body}");
      return sourcesList;
    } catch (error) {
      log("Error in getAllSources: $error");
      throw Exception("Failed to fetch sources: $error");
    }
  }
  static Future<List<ArticleData>> getAllArticles(String sourceID) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "apiKey": APIConstants.apiKey,
        "sources": sourceID,
      };

      final response = await http.get(
        Uri.https(
          APIConstants.baseURl,
          EndPoints.topHeadLines,
          queryParameters,
        ),
      );

      List<ArticleData> articlesList = [];

      if (response.statusCode == 200) {
        // logic Json as String
        // 1- convert to Json
        // 2- convert to List of SourceData

        var data = jsonDecode(response.body);

        for (var element in data["articles"]) {
          var dataObject = ArticleData.formJson(element);
          articlesList.add(dataObject);
        }
        log(articlesList.length.toString());
      }

      return articlesList;
    } catch (error) {
      throw Exception();
    }
  }
  }