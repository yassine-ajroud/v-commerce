import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 65,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.extraLightBlueColor,
            borderRadius: BorderRadius.circular(30)
          ),        ),

      Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //mainAxisSize: MainAxisSize.max,
              children: [
               const NavBarItem(icon: APPSVG.homeIcon, index: 0,selectedIcon: APPSVG.selectedHomeIcon,),
               const NavBarItem(icon: APPSVG.categoryIcon, index: 1,selectedIcon: APPSVG.selectedCategoryIcon,),
                    CircleAvatar(backgroundColor: AppColors.secondary,radius: 40,child: SvgPicture.string(APPSVG.arIcon,width: 30) ,),
               const NavBarItem(icon: APPSVG.serviceIcon, index: 2,selectedIcon: APPSVG.selectedServiceIcon,),
               const NavBarItem(icon: APPSVG.wishlistIcon, index: 3,selectedIcon: APPSVG.selectedWishlistIcon,),
              ],
            ),
          ),
      ],
    );
  }
}