import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/constants_assets.dart';
import 'package:news_app/models/source.dart';

class ArticlesView extends StatefulWidget {
  const ArticlesView({super.key});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

int selectedIndex = 0;

class _ArticlesViewState extends State<ArticlesView> {
  final List<SourceData> _sourceList = [
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
    SourceData(sourceId: "bbc", sourceName: "bbc"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        DefaultTabController(
          length: _sourceList.length,
          child: TabBar(
            onTap: (int value) {
              setState(() {
                selectedIndex = value;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 5),
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.black,
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.symmetric(horizontal: 10),

            isScrollable: true,
            tabs: _sourceList.map((sourceData) {
              return Text(
                sourceData.sourceName,
                style: TextStyle(
                  fontSize: _sourceList.indexOf(sourceData) == selectedIndex
                      ? 25
                      : 18,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
        ),
        Gap(20),
        Expanded(

          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black)
                ),

                child: Column(
                  children: [
                    Image(image: AssetImage(AppAssets.articles_img)),
                    Text(
                      "40-year-old man falls 200 feet to his death\n while canyoneering at national park",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Text(
                          "By : Jon Haworth",
                          style: TextStyle(fontSize: 15, color: Color(0xFFA0A0A0)),
                        ),
                        Spacer(),
                        Text(
                          " 15 minutes ago",
                          style: TextStyle(fontSize: 15, color: Color(0xFFA0A0A0)),
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
    );
  }
}
