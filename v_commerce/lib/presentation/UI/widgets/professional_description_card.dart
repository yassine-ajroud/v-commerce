import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ProfessionalDescriptionCard extends StatelessWidget {
  final String description;
  final int experience;
  const ProfessionalDescriptionCard({super.key,required this.description,required this.experience});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: AppColors.extraLightBlueColor,
            borderRadius: BorderRadius.circular(25)
          ),
          width: double.infinity,
          child:Padding(
            padding: const EdgeInsets.all(30.0),
            child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description',style: AppTextStyle.appBarTextButtonStyle,),
                    const SizedBox(height: 5,),
                    Text(description,style: AppTextStyle.smallblackTextStyle,),
                    const SizedBox(height: 20,),
Text('Experience',style: AppTextStyle.appBarTextButtonStyle,),
                    const SizedBox(height: 5,),
                    Text('$experience ans',style: AppTextStyle.smallblackTextStyle,),
                  ],
                )
          ),
        );
  }
}