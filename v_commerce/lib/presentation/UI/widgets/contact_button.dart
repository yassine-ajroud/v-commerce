import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ContactButon extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  final void Function() onClick;
  const ContactButon({super.key,required this.color,required this.icon,required this.text,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        //width: 200.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
          child: Row(children: [
            SvgPicture.string(icon,color: AppColors.white,),
            const SizedBox(width: 10,),
            Text(text,style: AppTextStyle.smallWhiteTitleTextStyle,)
          ],),
        ),
      ),
    );
  }
}