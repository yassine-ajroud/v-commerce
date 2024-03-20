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
    return SizedBox(
      width: 325.w,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          minimumSize: MaterialStateProperty.all(Size(325.w, 50.h)),
          foregroundColor: MaterialStateProperty.all(AppColors.primary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primary, width: 2.w),
              borderRadius: BorderRadius.circular(13.r),
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w,),

            SizedBox(
              height: 25.h,
              width: 25.w,
              child: Image(image: AssetImage(asset)),
            ),
            SizedBox(width: 30.w,),
                        Text(text)
    
          ],
        ),
      ),
    );
  }
}