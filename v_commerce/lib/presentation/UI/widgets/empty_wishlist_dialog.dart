import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyWishlistDialog extends StatelessWidget {
  const EmptyWishlistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: AppColors.extraLightBlueColor,
      title: Text(AppLocalizations.of(context)!.arr_session_promblem_title,style:  AppTextStyle.smallBlackTitleTextStyle,),
      content: Text(AppLocalizations.of(context)!.arr_session_promblem_text,style: AppTextStyle.descriptionTextStyle),

    );
  }
}