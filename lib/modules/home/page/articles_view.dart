import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/models/articale_data.dart';
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
  TextEditingController searchController = TextEditingController();

  List<SourceData> sourcesList = [];
  List<ArticleData> articlesList = [];
  List<ArticleData> displayArticles = [];

  @override
  void initState() {
    super.initState();
    loadSourcesAndArticles();
  }

  Future<void> loadSourcesAndArticles() async {
    try {
      sourcesList = await APIServices.getAllSources(widget.selectedCategory!.categoryId);

      if (sourcesList.isNotEmpty) {
        await fetchArticles(sourcesList.first.sourceId);
      }

      setState(() {});
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> fetchArticles(String sourceId) async {
    try {
      articlesList = await APIServices.getAllArticles(sourceId);

      displayArticles = List.from(articlesList);

      if (searchController.text.isNotEmpty) {
        filterArticles(searchController.text);
      }

      setState(() {});
    } catch (e) {
      throw Exception();
    }
  }


  void filterArticles(String keyword) {
    setState(() {
      displayArticles = keyword.isEmpty
          ? articlesList
          : articlesList
          .where((article) =>
          article.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sourcesList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: sourcesList.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search articles...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: filterArticles,
            ),
          ),

          // التبويبات
          TabBar(
            onTap: (value) async {
              setState(() => selectedIndex = value);
              await fetchArticles(sourcesList[value].sourceId);
            },
            isScrollable: true,
            indicatorColor: Colors.black,
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

          Expanded(
            child: ListView.builder(
              itemCount: displayArticles.length,
              itemBuilder: (context, index) {
                final article = displayArticles[index];
                return Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFF171717)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: article.urlToImage,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const SizedBox(
                          height: 220,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(
                          height: 220,
                          child: Icon(Icons.error, size: 50),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF171717),
                          height: 1.1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "By : ${article.source.sourceName}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA0A0A0),
                              ),
                            ),
                          ),
                          Text(
                            timeAgo(DateTime.parse(article.publishedAt)),
                            style: const TextStyle(
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
            ),
          ),
        ],
      ),
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
