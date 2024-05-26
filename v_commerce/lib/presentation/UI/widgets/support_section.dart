import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/core/styles/text_styles.dart';


class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text('${AppLocalizations.of(context)!.address} :',style: AppTextStyle.smallBlackTitleTextStyle,),
                const SizedBox(height: 5,),
        Text('R56P+C9J, Av. Mohamed 5, Tunis',style: AppTextStyle.descriptionTextStyle,),

        const SizedBox(height: 20,),
        Text('${AppLocalizations.of(context)!.phone_number} :',style: AppTextStyle.smallBlackTitleTextStyle,),
                    const SizedBox(height: 5,),
        Text('+216 71 000 000',style: AppTextStyle.descriptionTextStyle,),

        const SizedBox(height: 20,),
        Text('${AppLocalizations.of(context)!.email} :',style: AppTextStyle.smallBlackTitleTextStyle,),
                    const SizedBox(height: 5,),
        Text('Instarcontact@gmail.com',style: AppTextStyle.descriptionTextStyle,)

      ],),
    );
  }
}