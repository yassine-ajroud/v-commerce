
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';


class MyButton extends StatelessWidget {
  
  final String text ;
  final Color? color;
  final void Function()? click;
  const MyButton({super.key, required this.text ,required this.click,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 50.h,
        minHeight: 50.h,
        minWidth: double.infinity,
        maxWidth: double.infinity
      ),
               // width: 150.w,
                child: ElevatedButton(onPressed:click,style: ButtonStyle(backgroundColor:MaterialStateProperty.all(color ??AppColors.secondary),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side:  BorderSide(color :color??AppColors.secondary)
                  )
                )), child: Text(text,style: AppTextStyle.buttonTextStyle)
                ),
              )
      

    ;
  }
}