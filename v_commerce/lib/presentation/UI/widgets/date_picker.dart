import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
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
            height: 35.h,
            width: double.infinity,
            decoration: const BoxDecoration(
               border: Border(
                bottom: BorderSide(width: 1.0, color: AppColors.black),
             ),
            ),
            child: Text.rich(TextSpan(children:[const WidgetSpan(child:Padding(
              padding: EdgeInsets.symmetric(horizontal:10.0),
              child: Icon(Icons.calendar_today),
            ) ),TextSpan(text:controller.birthDate?? AppLocalizations.of(context)!.birth_date,style: AppTextStyle.smallblackTextStyle )])),
          ),
        );
      }
    );
  }
}