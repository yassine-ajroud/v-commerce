import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

import '../../../core/styles/colors.dart';
import '../../controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CityInput extends StatefulWidget {
  const CityInput({super.key});

  @override
  State<CityInput> createState() => _CityInputState();
}

class _CityInputState extends State<CityInput> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (controller) {
          return Container(
              width: double.infinity,
              height: 55.h,
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: AppColors.black),
                  borderRadius: BorderRadius.circular(10)),
              child:  DropdownButton<String>(
                    isExpanded: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    value: controller.city,
                    hint: Text(
                      AppLocalizations.of(context)!.city,
                      style: AppTextStyle.smallblackTextStyle,
                    ),
                    onChanged: (value) {
                      controller.setCity(value!);
                    },

                    items: [
                      DropdownMenuItem(value: 'ariana',child: Text(AppLocalizations.of(context)!.ariana),),
                      DropdownMenuItem(value: 'beja',child: Text(AppLocalizations.of(context)!.beja),),
                      DropdownMenuItem(value: 'ben_arous',child: Text(AppLocalizations.of(context)!.ben_arous),),
                      DropdownMenuItem(value: 'bizerte',child: Text(AppLocalizations.of(context)!.bizerte),),
                      DropdownMenuItem(value: 'gabes',child: Text(AppLocalizations.of(context)!.gabes),),
                      DropdownMenuItem(value: 'gafsa',child: Text(AppLocalizations.of(context)!.gafsa),),
                      DropdownMenuItem(value: 'jendouba',child: Text(AppLocalizations.of(context)!.jendouba),),
                      DropdownMenuItem(value: 'kairouan',child: Text(AppLocalizations.of(context)!.kairouan),),
                      DropdownMenuItem(value: 'kasserine',child: Text(AppLocalizations.of(context)!.kasserine),),
                      DropdownMenuItem(value: 'kebili',child: Text(AppLocalizations.of(context)!.kebili),),
                      DropdownMenuItem(value: 'kef',child: Text(AppLocalizations.of(context)!.kef),),
                      DropdownMenuItem(value: 'mahdia',child: Text(AppLocalizations.of(context)!.mahdia),),
                      DropdownMenuItem(value: 'manouba',child: Text(AppLocalizations.of(context)!.manouba),),
                      DropdownMenuItem(value: 'medenine',child: Text(AppLocalizations.of(context)!.medenine),),
                      DropdownMenuItem(value: 'monastir',child: Text(AppLocalizations.of(context)!.monastir),),
                      DropdownMenuItem(value: 'nabeul',child: Text(AppLocalizations.of(context)!.nabeul),),
                      DropdownMenuItem(value: 'sfax',child: Text(AppLocalizations.of(context)!.sfax),),
                      DropdownMenuItem(value: 'sidi_bouzid',child: Text(AppLocalizations.of(context)!.sidi_bouzid),),
                      DropdownMenuItem(value: 'siliana',child: Text(AppLocalizations.of(context)!.siliana),),
                      DropdownMenuItem(value: 'sousse',child: Text(AppLocalizations.of(context)!.sousse),),
                      DropdownMenuItem(value: 'tataouine',child: Text(AppLocalizations.of(context)!.tataouine),),
                      DropdownMenuItem(value: 'tozeur',child: Text(AppLocalizations.of(context)!.tozeur),),
                      DropdownMenuItem(value: 'tunis',child: Text(AppLocalizations.of(context)!.tunis),),
                      DropdownMenuItem(value: 'zaghouan',child: Text(AppLocalizations.of(context)!.zaghouan),),
                    ]
                  
                  ));
                },
              );
  }
}
