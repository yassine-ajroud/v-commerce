import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class DrawerItem extends StatelessWidget {
 final String label;
 final String icon;
 final int index;
 final void Function() onTap;
 final int groupeIndex;
 final Widget? tariling;
  const DrawerItem({super.key,required this.label,required this.icon,required this.index,required this.onTap,required this.groupeIndex, this.tariling});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: index==groupeIndex?AppColors.secondary:Colors.transparent,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              leading: SvgPicture.string(icon,color:index==groupeIndex?AppColors.white:AppColors.black ,),
              title: Text(label,style: index == groupeIndex? AppTextStyle.smallWhiteTitleTextStyle:AppTextStyle.smallBlackTitleTextStyle,),
              trailing: tariling,
            ),
          ),
        ),
      ),
    );
  }
}