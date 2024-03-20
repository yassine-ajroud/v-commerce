import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';


// ignore: must_be_immutable
class LanguageItem extends StatelessWidget {
  final String language;
  final String value;
  void Function(String?) onChanged;
  String gvalue;
  LanguageItem({
    super.key,
    required this.language,
    required this.value,
     required this.gvalue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1)
        
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              language,
              style: AppTextStyle.smallblackTextButtonStyle,
            ),
           
               Radio<String>(
                      activeColor: AppColors.primary,
                      value: value,
                      groupValue: gvalue,
                      onChanged:onChanged
                    )
          ]),
        ),
      ),
    );
  }
}
