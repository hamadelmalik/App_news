import 'package:flutter/material.dart';
import 'package:news_app/models/category_data.dart';

class CategoryItem extends StatelessWidget {
  final CategoryData categoryData;
  final int index;
  final Function(CategoryData) onTap;
  const CategoryItem({
    super.key,
    required this.categoryData,
    required this.index,
  required  this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: index.isEven ? Alignment.bottomRight : Alignment.bottomLeft,
      height: 200,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(image: AssetImage(categoryData.categoryImage)),
      ),

      child: GestureDetector(
        onTap: () {
          onTap(categoryData);
        },
        child: Container(
          height: 55,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white70,
          ),
          child: Directionality(
            textDirection: index.isEven ? TextDirection.ltr : TextDirection.rtl,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "View All",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
