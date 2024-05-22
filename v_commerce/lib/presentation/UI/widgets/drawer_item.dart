import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              leading: SvgPicture.string(icon,),
              title: Text(label,style:AppTextStyle.smallBlackTitleTextStyle,),
              trailing: tariling,
            ),
          ),
        ),
      ),
    );
  }
}