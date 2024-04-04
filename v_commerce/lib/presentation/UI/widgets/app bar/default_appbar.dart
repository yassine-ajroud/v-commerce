import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget  {
    final void Function()? click;

  const DefaultAppBar({super.key,required this.click});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor:  AppColors.backgroundWhite,
                  backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(onPressed: click, icon:const Icon(Icons.arrow_back,size: 30,color: AppColors.black,)),
        );
  }
  
  @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}