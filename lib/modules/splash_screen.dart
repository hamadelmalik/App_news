import 'package:flutter/material.dart';
import 'package:news_app/core/constants/constants_assets.dart';
import 'package:news_app/core/route/page_route_name.dart';
import 'package:news_app/main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        PageRouteName.homeView,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image(image: AssetImage(AppAssets.appLogo)),
    );
  }
}
