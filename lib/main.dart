import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/route/page_route.dart';
import 'package:news_app/core/route/page_route_name.dart';
import 'package:news_app/modules/home/cubit/articale_cubit.dart';
import 'package:news_app/modules/home/cubit/home_cubit.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ArticlesCubit()), // 👈 ضروري
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: PageRouteName.initial,
        onGenerateRoute: AppRoute.onGenerateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
