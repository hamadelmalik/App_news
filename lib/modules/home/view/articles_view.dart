import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/modules/home/cubit/articale_cubit.dart';
import 'package:news_app/modules/home/cubit/articles_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticlesView extends StatelessWidget {
  final CategoryData selectedCategory;

  const ArticlesView({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          final viewModel = context.watch<ArticlesCubit>();
          if (viewModel.isLoadingArticles) {
            viewModel.getAllSources(selectedCategory.categoryId);
          }

          return Column(
           // mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,

            spacing: 10,
            children: [
              if (viewModel.isLoadingSources)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearProgressIndicator(),
                )
              else
                DefaultTabController(
                  length: viewModel.sourcesList.length,
                  child: TabBar(
                    onTap: viewModel.changeTabIndex,
                    isScrollable: true,
                    indicatorColor: Colors.black,
                    dividerColor: Colors.transparent,
                    tabs: viewModel.sourcesList.map((s) {
                      return Text(
                        s.sourceName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight:
                              viewModel.sourcesList.indexOf(s) ==
                                  viewModel.selectedIndex
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      );
                    }).toList(),
                  ),
                ),

              const SizedBox(height: 10),

              Expanded(
                child: viewModel.isLoadingArticles
                    ? ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) =>
                            Shimmer(
                              duration: Duration(seconds: 1),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 220,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.filteredList.length,
                        itemBuilder: (context, index) {
                          final article = viewModel.filteredList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: article.urlToImage,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) =>
                                      const Icon(Icons.error),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "By: ${article.source.sourceName}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        viewModel.timeAgo(article.publishedAt),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
