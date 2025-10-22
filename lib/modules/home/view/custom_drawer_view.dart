import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/constants_assets.dart';

class CustomDrawerView extends StatelessWidget {
  final Function() onTap;
  const CustomDrawerView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.black,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.24,
            color: Colors.white,
            child: Text(
              "News App",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Gap(20),
          Row(
            children: [
              GestureDetector(
                onTap: onTap,

               child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.home_max, color: Colors.white, size: 40),
                ),
              ),
              Gap(20),
              Text(
                "Go To Home",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Gap(20),
            ],
          ),
          Divider(color: Colors.white, thickness: 2, indent: 15, endIndent: 15),
          Gap(20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Image.asset(
                  AppAssets.themeIcn,
                  color: Colors.white,
                  width: 30,
                  height: 30,
                ),
              ),
              Gap(20),
              Text(
                "Theme",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Gap(20),
            ],
          ),
        ],
      ),
    );
  }
}
