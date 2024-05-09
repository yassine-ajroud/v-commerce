import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ExpandableHeader extends StatelessWidget {
  final String icon;
  final String title;
  final bool expanded;
  final void Function() onPress;
  const ExpandableHeader({super.key,required this.expanded,required this.icon, required this.onPress,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
           SvgPicture.string(icon),
          const SizedBox(width: 10,),
            Text(title,style: AppTextStyle.blackTitleTextStyle,),
            const Spacer(),
            IconButton(onPressed: onPress, icon: Icon(expanded? Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined))
        ],),
        Divider(thickness: 1,)
      ],
    );
  }
}