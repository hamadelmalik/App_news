import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/modules/home/cubit/articale_cubit.dart';
import 'package:news_app/modules/home/view/articles_view.dart';
import 'package:news_app/modules/home/view/custom_drawer_view.dart';
import 'package:news_app/modules/home/widgets/categoryitem.dart';
import 'package:news_app/modules/home/cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final categoryList = [
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ArticlesCubit()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: true,
              drawer: CustomDrawerView(
                onGoHome: () {
                  Navigator.pop(context);
                  cubit.goHome();
                },
              ),
              appBar: state.selectedCategory == null
                  ? AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      title: const Text(
                        'News App',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: state.isSearching
                          ? SizedBox(
                              height: 40,
                              child: TextField(
                                autofocus: true,
                                onChanged: (query) {
                                  // 🔹 هنا البحث الفعلي
                                  context.read<ArticlesCubit>().searchArticles(
                                    query,
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search articles...',
                                  prefixIcon: const Icon(Icons.search),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              state.selectedCategory?.categoryName ??
                                  'Articles',
                              style: const TextStyle(color: Colors.black),
                            ),
                      actions: [
                        IconButton(
                          icon: Icon(
                            state.isSearching ? Icons.close : Icons.search,
                            color: Colors.black,
                          ),
                          onPressed: cubit.toggleSearch,
                        ),
                      ],
                    ),

              body: state.selectedCategory == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              "Good Morning\nHere is Some News For You",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(20),
                            ...categoryList.map((categoryData) {
                              return CategoryItem(
                                categoryData: categoryData,
                                index: categoryList.indexOf(categoryData),
                                onTap: cubit.selectCategory,
                              );
                            }),
                          ],
                        ),
                      ),
                    )
                  : ArticlesView(selectedCategory: state.selectedCategory!),
            ),
          );
        },
      ),
    );
  }
}
