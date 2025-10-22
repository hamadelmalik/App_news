import 'package:flutter/material.dart';
import 'package:news_app/modules/home/view_model/articale_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/category_data.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticlesListView extends StatelessWidget {
  final CategoryData selectedCategory;

  const ArticlesListView({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ArticlesViewModel()..getAllSources(selectedCategory.categoryId),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(height: 15),
          Consumer<ArticlesViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.isLoadingSources
                  ? Shimmer(
                      duration: Duration(seconds: 1),
                      interval: Duration(milliseconds: 800),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade300,
                        ),
                      ),
                    )
                  : DefaultTabController(
                      length: viewModel.sourcesList.length,
                      child: TabBar(
                        onTap: viewModel.changeTabIndex,
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        dividerColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        indicatorPadding: EdgeInsets.zero,
                        tabAlignment: TabAlignment.start,
                        tabs: viewModel.sourcesList.map((sourceData) {
                          return Text(
                            sourceData.sourceName,
                            style: TextStyle(
                              fontSize:
                                  viewModel.sourcesList.indexOf(sourceData) ==
                                      viewModel.selectedIndex
                                  ? 18
                                  : 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }).toList(),
                      ),
                    );
            },
          ),
          Consumer<ArticlesViewModel>(
            builder: (context, viewModel, child) {
              return Expanded(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return viewModel.isLoadingArticles
                        ? Shimmer(
                            duration: Duration(seconds: 1),
                            interval: Duration(milliseconds: 800),
                            child: Container(
                              height: 360,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: Colors.black26),
                                color: Colors.grey.shade300,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Color(0xFF171717)),
                            ),
                            child: Column(
                              spacing: 10,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      viewModel.articlesList[index].urlToImage,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  placeholder: (context, url) => SizedBox(
                                    height: 220,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      SizedBox(
                                        height: 220,
                                        child: Icon(Icons.error, size: 50),
                                      ),
                                ),
                                Text(
                                  viewModel.articlesList[index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF171717),
                                    height: 1.1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "By : ${viewModel.articlesList[index].source.sourceName}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFA0A0A0),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      viewModel.articlesList[index].publishedAt,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA0A0A0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                  },
                  itemCount: viewModel.isLoadingArticles
                      ? 5
                      : viewModel.articlesList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
