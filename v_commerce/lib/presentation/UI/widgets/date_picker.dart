import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DatePickerInput extends StatefulWidget {
  const DatePickerInput({super.key});

  @override
  State<DatePickerInput> createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return GestureDetector(
          onTap:()async{
                  final now = DateTime.now();
             final date = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(1900), lastDate: DateTime(now.year+10));
              if(date!=null){
              controller.setBirthDate(date);
        
              }
                } ,
          child: Container(
            height: 45.h,
            width: double.infinity,
            decoration:  BoxDecoration(
              color: AppColors.lightgrey,
              border: null,
               borderRadius: BorderRadius.circular(25)
            ),
            child: Text.rich(
              TextSpan(children:[ WidgetSpan(                alignment: PlaceholderAlignment.middle,
child:Padding(
              padding:const EdgeInsets.symmetric(horizontal:20.0,vertical: 15),
              child: SvgPicture.string(APPSVG.calendarIcon),
            ) ),TextSpan(text:controller.birthDate?? AppLocalizations.of(context)!.birth_date,style: AppTextStyle.smallBlackTitleTextStyle )])),
          ),
        );
      }
    );
  }
}