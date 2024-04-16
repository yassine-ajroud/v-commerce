import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/svg.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return  TextField(
                    keyboardType: TextInputType.text,
                    
                    decoration: InputDecoration(
                      prefixIcon:Padding(
                        padding: Adaptivity.textFieldIconPadding('en'),
                        child: SvgPicture.string(APPSVG.searchIcon,)
                      ), 
                      hintText: "Recherche",
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