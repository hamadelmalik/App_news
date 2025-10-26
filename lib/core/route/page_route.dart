import 'package:flutter/material.dart';
import 'package:news_app/core/route/page_route_name.dart';
import 'package:news_app/modules/home/view/home_view.dart';
import 'package:news_app/modules/splash_screen.dart';

abstract class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case PageRouteName.homeView:
        return MaterialPageRoute(builder: (context) => const HomeView());
      // case PageRouteName.articlesView:
      //   return MaterialPageRoute(builder: (context) => const ArticlesView(selectedCategory: cat,));
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
