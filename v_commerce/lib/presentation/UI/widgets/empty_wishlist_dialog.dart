import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class EmptyWishlistDialog extends StatelessWidget {
  const EmptyWishlistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: AppColors.extraLightBlueColor,
      title: Text("sorry! you can't start an AR session because your wishlist is empty",style:  AppTextStyle.smallBlackTitleTextStyle,),
      content: Text("Add some products to your wishlist then try again",style: AppTextStyle.descriptionTextStyle),

    );
  }
}