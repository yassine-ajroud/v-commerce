import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

import '../../../core/styles/colors.dart';
import '../../controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class GenderInput extends StatefulWidget {
  const GenderInput({super.key});

  @override
  State<GenderInput> createState() => _GenderInputState();

}

class _GenderInputState extends State<GenderInput> {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: 55.h,
          decoration: BoxDecoration(
            border:Border.all(width: 2.0,color: AppColors.black),
            borderRadius: BorderRadius.circular(10)
         
          ),
          child: DropdownButton<String>(

            underline: null,
                      isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
           value: controller.gender,
           hint: Text(AppLocalizations.of(context)!.gender,style: AppTextStyle.smallblackTextStyle,),
          onChanged: (value){
            controller.setGender(value!);
          },
          items: [
            DropdownMenuItem<String>(value: 'male',child: Text(AppLocalizations.of(context)!.male),),
            DropdownMenuItem<String>(value: 'female',child: Text(AppLocalizations.of(context)!.female),)


          ],
          )
        );
      }
    );
  }
}