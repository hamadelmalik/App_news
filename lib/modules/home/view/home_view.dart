import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/modules/home/view//articles_view.dart';
import 'package:news_app/modules/home/view/custom_drawer_view.dart';
import 'package:news_app/modules/home/widgets/categoryitem.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}
CategoryData? selectedCategory;
List<CategoryData> categoryList = [
  CategoryData(
    categoryId: 'General',
    categoryName: 'General',
    categoryImage: 'assets/images/general.png',
  ),
  CategoryData(
    categoryId: 'Business',
    categoryName: 'Business',
    categoryImage: 'assets/images/business_img.png',
  ),
  CategoryData(
    categoryId: 'Sports',
    categoryName: 'Sports',
    categoryImage: 'assets/images/sports_img.png',
  ),
  CategoryData(
    categoryId: 'Health',
    categoryName: 'Health',
    categoryImage: 'assets/images/health_img.png',
  ),
  CategoryData(
    categoryId: 'Science',
    categoryName: 'Science',
    categoryImage: 'assets/images/science_img.png',
  ),
  CategoryData(
    categoryId: 'Technology',
    categoryName: 'Technology',
    categoryImage: 'assets/images/technology_img.png',
  ),
  CategoryData(
    categoryId: 'Entertainment',
    categoryName: 'Entertainment',
    categoryImage: 'assets/images/entertainment_img.png',
  ),
];

class _HomeViewState extends State<HomeView> {
 // TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearching = false;
  String searchKeyword = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        key: scaffoldKey,
        drawer: CustomDrawerView(
          onTap: () {
            setState(() {
              selectedCategory = null;
            });
            Navigator.of(context).pop(); // يغلق Drawer عند الضغط على عنصر
          },
        ),
        appBar: AppBar(
          title: isSearching
              ? TextField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                searchKeyword = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search articles...',
              border: InputBorder.none,
            ),
          )
              : Text(
            selectedCategory == null
                ? "Home"
                : selectedCategory!.categoryName,
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            if (selectedCategory != null)
              IconButton(
                icon: Icon(isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    if (isSearching) searchKeyword = '';
                    isSearching = !isSearching;
                  });
                },
              ),
          ],
        ),
        body: Column(
          children: [


            Expanded(
              child: selectedCategory == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Good Morning\nHere is Some News For You",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
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
                      //searchKeyword: searchController.text,
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
