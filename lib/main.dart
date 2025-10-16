import 'package:flutter/material.dart';
import 'package:news_app/core/route/page_route.dart';
import 'package:news_app/core/route/page_route_name.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
