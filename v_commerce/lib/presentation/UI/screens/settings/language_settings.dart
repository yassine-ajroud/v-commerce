import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../widgets/language_item.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.lang,
            style: AppTextStyle.secondaryBlackTitleTextStyle,
          ),
        ),
        body: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return Column(
              children: [
                LanguageItem(
                  language: AppLocalizations.of(context)!.fr,
                  value: 'fr',
                  gvalue: controller.currentlocale,
                  onChanged: (v) async{
                    await controller.saveLocale(v!);
                  },
                ),
                LanguageItem(
                    language: AppLocalizations.of(context)!.en,
                    value: 'en',
                     gvalue: controller.currentlocale,
                  onChanged: (v) async{
                    await controller.saveLocale(v!);
                  },),
                LanguageItem(
                  language: AppLocalizations.of(context)!.ar,
                  value: 'ar',
                   gvalue: controller.currentlocale,
                  onChanged: (v) async{
                    await controller.saveLocale(v!);
                  },
                ),
                
              ],
            );
          },
        ),
      ),
    );
  }
}
