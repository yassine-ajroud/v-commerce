import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final  Function(String)? onChanged;
  const SearchInput({super.key,required this.controller,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  TextField(
                    keyboardType: TextInputType.text,
                    controller: controller,
                    onChanged:onChanged ,
                    decoration: InputDecoration(
                      prefixIcon:Padding(
                        padding: Adaptivity.textFieldIconPadding('en'),
                        child: SvgPicture.string(APPSVG.searchIcon,)
                      ), 
                      hintText: AppLocalizations.of(context)!.search,
                      hintStyle: AppTextStyle.hintTextStyle,
                      enabled: true,
                      filled: true,
                      fillColor:AppColors.lightBlue,
                     
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:const BorderSide(
                style: BorderStyle.none,
                color: AppColors.lightBlue
            ),
        ),

        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:const BorderSide(
                style: BorderStyle.none,
                color: AppColors.lightBlue
            ),
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:const BorderSide(
                style: BorderStyle.none,
                color: AppColors.lightBlue
            ),
        ),
        
                     // borderRadius: BorderRadius.circular(8.0),
                      //color: Color(0xffF0F1F5),
                    ),
                  );
  }
}