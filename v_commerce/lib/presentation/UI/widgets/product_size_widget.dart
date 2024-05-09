import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ProductSizeWidget extends StatelessWidget {
  final String icon;
  final double value;
  final String title;
  const ProductSizeWidget({super.key, required this.icon,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
         NumberFormat formatter = NumberFormat();
  formatter.minimumFractionDigits = 0;
  formatter.maximumFractionDigits = 2;
    return Column(
      children:[
         Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
           child: Container(
            height: 70.h,
            width: 70.w,
                 decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(15)
                 ),
                 child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(icon),
              const SizedBox(height: 5,),
              Text("${formatter.format(value)} cm",style: AppTextStyle.smallDarkButtonTextStyle,),
            ],
         
                 ),
               ),
         ),
                  Text(title,style: AppTextStyle.descriptionTextStyle,),

      ]
     
    );
  }
}