import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ExpandableSettingsHeader extends StatelessWidget {
  final String icon;
  final String title;
  final bool expanded;
  final void Function() onPress;
  const ExpandableSettingsHeader({super.key,required this.expanded,required this.icon, required this.onPress,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color:expanded? AppColors.secondary : AppColors.backgroundWhite
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
               SvgPicture.string(icon,color: expanded?AppColors.backgroundWhite: AppColors.black ,),
              const SizedBox(width: 10,),
                Text(title,style:expanded? AppTextStyle.whiteSettingsTitleTextStyle: AppTextStyle.blackSettingsTitleTextStyle,),
                const Spacer(),
                IconButton(onPressed: onPress, icon: Icon(expanded? Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined,color:  expanded?AppColors.backgroundWhite: AppColors.black ,))
            ],),
          ],
        ),
      ),
    );
  }
}