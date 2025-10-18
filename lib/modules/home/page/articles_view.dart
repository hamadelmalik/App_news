import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/models/artical_data.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/network/api_services.dart';

class ArticlesView extends StatefulWidget {
  final CategoryData? selectedCategory;

  const ArticlesView({super.key, this.selectedCategory});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SourceData>>(
      future: APIServices.getAllSources(widget.selectedCategory!.categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        List<SourceData> sourcesList = snapshot.data ?? [];

        if (sourcesList.isEmpty) {
          return const Center(child: Text("No sources found 😕"));
        }

        return DefaultTabController(
          length: sourcesList.length,
          child: Column(
            children: [
              Gap(10),
              TabBar(
                onTap: (int value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 5),
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.black,
                dividerColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                isScrollable: true,
                tabs: sourcesList.map((sourceData) {
                  final isSelected =
                      sourcesList.indexOf(sourceData) == selectedIndex;
                  return Text(
                    sourceData.sourceName,
                    style: TextStyle(
                      fontSize: isSelected ? 20 : 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
              Gap(20),
              ////////futurebuldir////////////////////
              FutureBuilder(
                future: APIServices.getAllArticles(
                  sourcesList[selectedIndex].sourceId,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<ArticleData> articlesList = snapshot.data ?? [];

                  return Expanded(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
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
                                imageUrl: articlesList[index].urlToImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      height: 220,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
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
                                errorWidget: (context, url, error) => SizedBox(
                                  height: 220,
                                  child: Icon(Icons.error, size: 50),
                                ),
                              ),
                              Text(
                                articlesList[index].title,
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
                                      "By : ${articlesList[index].source.sourceName}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA0A0A0),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${timeAgo(DateTime.parse(articlesList[index].publishedAt))}",
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
                      itemCount: articlesList.length,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String timeAgo(DateTime articleDate) {
    final now = DateTime.now();
    final difference = now.difference(articleDate);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }
}
