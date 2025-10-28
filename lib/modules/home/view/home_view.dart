import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/modules/home/view/articles_view.dart';
import 'package:news_app/modules/home/view/custom_drawer_view.dart';
import 'package:news_app/modules/home/widgets/categoryitem.dart';
import 'package:news_app/modules/home/cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // قائمة التصنيفات
    final categoryList = [
      CategoryData(categoryId: 'General', categoryName: 'General', categoryImage: 'assets/images/general.png'),
      CategoryData(categoryId: 'Business', categoryName: 'Business', categoryImage: 'assets/images/business_img.png'),
      CategoryData(categoryId: 'Sports', categoryName: 'Sports', categoryImage: 'assets/images/sports_img.png'),
      CategoryData(categoryId: 'Health', categoryName: 'Health', categoryImage: 'assets/images/health_img.png'),
      CategoryData(categoryId: 'Science', categoryName: 'Science', categoryImage: 'assets/images/science_img.png'),
      CategoryData(categoryId: 'Technology', categoryName: 'Technology', categoryImage: 'assets/images/technology_img.png'),
      CategoryData(categoryId: 'Entertainment', categoryName: 'Entertainment', categoryImage: 'assets/images/entertainment_img.png'),
    ];

    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, CategoryData?>(
        builder: (context, selectedCategory) {
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: true,

              // Drawer
              drawer: CustomDrawerView(
                onGoHome: () {
                  Navigator.pop(context); // يقفل الـ Drawer
                  context.read<HomeCubit>().goHome(); // يرجع للهوم
                },
              ),

              // AppBar مع زر قائمة لفتح Drawer
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                ),
                title: const Text(
                  "News App",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              // Body: إما Home أو ArticlesView حسب state
              body: selectedCategory == null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Good Morning\nHere is Some News For You",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const Gap(20),
                      ...categoryList.map((categoryData) {
                        return CategoryItem(
                          categoryData: categoryData,
                          index: categoryList.indexOf(categoryData),

                            onTap: context.read<HomeCubit>().selectCategory,

                        );
                      }),
                    ],
                  ),
                ),
              )
                  : ArticlesView(selectedCategory: selectedCategory),
            ),
          );
        },
      ),
    );
  }
}
