import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ProfileButtonItem extends StatelessWidget {
  final String icon;
  final String text;
  final bool? trailing;
  final void Function() click;
  const ProfileButtonItem({super.key,required this.icon,required this.text,required this.click,this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        height: 50.h,
        decoration:const BoxDecoration(
          color: AppColors.backgroundWhite
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.string(icon),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 300,
                      child: Text(text,style: AppTextStyle.smallBlackTitleTextStyle,overflow: TextOverflow.visible,)),
                  )
                ],
              ),
           trailing??false?  const Icon(Icons.priority_high_rounded,color: AppColors.red,):Container()
            ],
            
          ),
        ),
      ),
    );
  }
}