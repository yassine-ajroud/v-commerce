import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class RateProgressWidget extends StatelessWidget {
  final String label;
  final double value;
  final Color? color;
  final double? width;
  final double? titleWidth;
  final Widget? trailing;
  const RateProgressWidget({super.key,required this.label,required this.value,this.color,this.width,this.trailing,this.titleWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width:titleWidth?? 80.w,
          child: Text(label,style: AppTextStyle.descriptionTextStyle,)),
       const SizedBox(width: 10,),
        SizedBox(
          width:width?? 100,
          child: LinearProgressIndicator(
              value: value,
              color:color?? AppColors.secondary,
              backgroundColor: AppColors.extraLightBlueColor,
              borderRadius: BorderRadius.circular(15),
          ),
        ),
        const SizedBox(width: 10,),
        trailing??const SizedBox()
      ],
    );
  }
}