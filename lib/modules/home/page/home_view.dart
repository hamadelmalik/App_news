import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/modules/home/page/articles_view.dart';
import 'package:news_app/modules/home/page/custom_drawer_view.dart';
import 'package:news_app/modules/home/widgets/categoryitem.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

CategoryData? selectedCategory;
List<CategoryData> categoryList = [
  CategoryData(categoryId: 'General', categoryName: 'General', categoryImage: 'assets/images/general.png'),
  CategoryData(categoryId: 'Business', categoryName: 'Business', categoryImage: 'assets/images/business_img.png'),
  CategoryData(categoryId: 'Sports', categoryName: 'Sports', categoryImage: 'assets/images/sports_img.png'),
  CategoryData(categoryId: 'Health', categoryName: 'Health', categoryImage: 'assets/images/health_img.png'),
  CategoryData(categoryId: 'Science', categoryName: 'Science', categoryImage: 'assets/images/science_img.png'),
  CategoryData(categoryId: 'Technology', categoryName: 'Technology', categoryImage: 'assets/images/technology_img.png'),
  CategoryData(categoryId: 'Entertainment', categoryName: 'Entertainment', categoryImage: 'assets/images/entertainment_img.png'),
];

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        drawer: CustomDrawerView(
          onTap: () {
            setState(() {
              selectedCategory = null;
              navigatorKey.currentState!.pop();
            });
          },
        ),
        body: Column(
          children: [
      
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                controller: searchController,
                style: TextStyle(color:Colors.black,),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  suffixIcon: Icon(Icons.cancel, color: Colors.red),
                  filled: true,
      
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white38, width: 2),
      
      
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // يعيد بناء ArticlesView بالكلمة الجديدة
                },
              ),
            ),
      
      
            Expanded(
              child: selectedCategory == null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Good Morning\nHere is Some News For You",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      Gap(20),
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
                  : ArticlesView(
                selectedCategory: selectedCategory!,
                searchKeyword: searchController.text,
              ),
            ),
          ],
        ),
      ),
    );


  }

  void onSelectCategory(CategoryData categoryData) {
    setState(() {
      selectedCategory = categoryData;
    });
  }
}