import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/controllers/main_screen_controller.dart';

class NavBarItem extends StatelessWidget {
  final String icon;
  final String selectedIcon;
  final int index;
  const NavBarItem({super.key,required this.icon,required this.index,required this.selectedIcon});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  MainScreenController(),
      builder: (controller) {
        return InkWell(
          onTap: (){
            controller.selectScreen(index);
          },          
          child:  SvgPicture.string(index==controller.selectedScreen?selectedIcon: icon),
        );
      }
    );
  }
}