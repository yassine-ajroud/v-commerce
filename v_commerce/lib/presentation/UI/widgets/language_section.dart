import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/presentation/UI/widgets/language_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SettingsController(),
      id: ControllerID.UPDTAE_LANGUAGE,
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
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
      }
    );
  }
}