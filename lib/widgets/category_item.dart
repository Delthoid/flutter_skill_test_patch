import 'package:flutter/material.dart';
import 'package:flutter_skill_test_patch/model/catergory.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.isSelected, required this.onTap});

  final Category category;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          width: 85,
          height: 85,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isSelected
                ? LinearGradient(
                    colors: [Color(0XFF4CBACC), Color(0XFF77D28B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
          ),
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 70,
                height: 70,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    child: Image.asset(
                      width: 70,
                      height: 70,
                      category.imagePath,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(category.name, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
