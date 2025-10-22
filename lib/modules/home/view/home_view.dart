import 'package:flutter/material.dart';
import 'package:news_app/core/constants/constants_assets.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/modules/home/view/articles_view.dart';
import 'package:news_app/modules/home/view/custom_drawer_view.dart';
import 'package:news_app/modules/home/widgets/categoryitem.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryData? selectedCategory;
  List<CategoryData> categoryList = [
    CategoryData(
      categoryId: 'general',
      categoryName: 'General',
      categoryImage :AppAssets.general,
    ),
    CategoryData(
      categoryId: 'business',
      categoryName: 'Business',
      categoryImage: AppAssets.business,
    ),
    CategoryData(
      categoryId: 'sports',
      categoryName: 'Sports',
      categoryImage: AppAssets.sports,
    ),
    CategoryData(
      categoryId: 'health',
      categoryName: 'Health',
      categoryImage: AppAssets.health,
    ),
    CategoryData(
      categoryId: 'science',
      categoryName: 'Science',
      categoryImage: AppAssets.sports,
    ),
    CategoryData(
      categoryId: 'technology',
      categoryName: 'Technology',
      categoryImage: AppAssets.technology,
    ),
    CategoryData(
      categoryId: 'entertainment',
      categoryName: 'Entertainment',
      categoryImage: AppAssets.entertainment,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? "Home" : selectedCategory!.categoryName,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      drawer: CustomDrawerView(
        onTap: () {
          setState(() {
            selectedCategory = null;
            navigatorKey.currentState!.pop();
          });
        },
      ),
      body:
      selectedCategory == null
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Good Morning\nHere is Some News For You",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF171717),
                  height: 1.1,
                ),
              ),
              ...categoryList.map((categoryData) {
                return CategoryItem(
                  categoryData: categoryData,
                  index: categoryList.indexOf(categoryData),
                  onTap: onSelectCategory,
                );
              }),
            ],
          ),
        ),
      )
          : ArticlesListView(selectedCategory: selectedCategory!),
    );
  }

  void onSelectCategory(CategoryData categoryData) {
    setState(() {
      selectedCategory = categoryData;
    });
  }
}