import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';

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
        return DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0),

         decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:  BorderRadius.all(
                         Radius.circular(30.0),
                        
                      ),
                    ),
                    filled: true,
                    hintText: AppLocalizations.of(context)!.gender,
                    fillColor:AppColors.lightgrey,
                    prefixIcon: SvgPicture.string(APPSVG.genderIcon,fit: BoxFit.scaleDown)
                    ),
                  isExpanded: true,
                  value: controller.gender,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30.0),
                    child: Text(
                      AppLocalizations.of(context)!.gender,
                      style: AppTextStyle.smallblackTextStyle,
                    ),
                  ),
                  onChanged: (value) {
                    controller.setGender(value!);
                  },
          
                  items: [
            DropdownMenuItem<String>(value: 'male',child: Text(AppLocalizations.of(context)!.male),),
            DropdownMenuItem<String>(value: 'female',child: Text(AppLocalizations.of(context)!.female),)


          ],
                
                ),
          );
      }
    );
  }
}