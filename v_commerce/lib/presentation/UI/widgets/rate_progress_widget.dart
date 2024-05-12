import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class RateProgressWidget extends StatelessWidget {
  final String label;
  final double value;
  const RateProgressWidget({super.key,required this.label,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,style: AppTextStyle.descriptionTextStyle,),
       const SizedBox(width: 10,),
        SizedBox(
          width: 130,
          child: LinearProgressIndicator(
              value: value,
              color: AppColors.secondary,
              backgroundColor: AppColors.extraLightBlueColor,
              borderRadius: BorderRadius.circular(15),
              
          ),
        )
      ],
    );
  }
}