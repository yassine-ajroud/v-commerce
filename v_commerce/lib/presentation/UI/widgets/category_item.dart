import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(category.image,fit: BoxFit.cover,height: 180,)),
        const SizedBox(height: 10,),
        Text(category.title,style: AppTextStyle.smallBlackTitleTextStyle,)
      ],
    );
  }
}