import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors.dart';

class SocialSecondaryButton extends StatelessWidget {
  final String text;
  final String asset;
  final void Function() onClick;
  const SocialSecondaryButton(
      {super.key, required this.text, required this.onClick, required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(
            width: 1.w, 
            color: AppColors.black          
          ),
          borderRadius: BorderRadius.circular(10.r)
        ),
        width: 90.w,
        height: 55.h,

          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Image(image: AssetImage(asset),fit: BoxFit.contain),
          ),
        
      ),
    );
  }
}