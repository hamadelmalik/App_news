import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/constants_assets.dart';
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
          return Center(child: Text(snapshot.error.toString()));
        }

        List<SourceData> sourcesList = snapshot.data ?? [];

        if (sourcesList.isEmpty) {
          return const Center(child: Text("No sources found"));
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
                      fontSize: isSelected ? 22 : 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
              const Gap(20),
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final source = sourcesList[selectedIndex];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(AppAssets.articles_img),
                          const Gap(10),
                          Text(
                            "Articles from ${source.sourceName}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(10),
                          const Row(
                            children: [
                              Text(
                                "By : Author Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFA0A0A0),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "15 minutes ago",
                                style: TextStyle(
                                  fontSize: 15,
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
      },
    );
  }
}
