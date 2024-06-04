import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/utils/svg.dart';

import '../../../core/styles/colors.dart';

// ignore: must_be_immutable
class InputText extends StatefulWidget {
  final String hint;
   bool ? isPassword;
  final String? leading; 
  final String? Function(String?)? validator;
  final TextEditingController? controler;
  final int ? length;
  final TextInputType ? type ;
   InputText({super.key, required this.hint,this.isPassword,this.type,this.controler,this.validator,this.length, this.leading});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
 late bool obs;
 late String icon ;
  @override
  void initState() {
    obs=widget.isPassword??false;
    icon =APPSVG.visibleIcon;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.length,
      validator: widget.validator,
      controller: widget.controler,
      
    obscureText: obs ,
    keyboardType: widget.type ?? TextInputType.text,
      decoration: InputDecoration(
        contentPadding:const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(35),borderSide: BorderSide.none),
        fillColor: AppColors.lightgrey,
        filled: true,
        hintText:widget.hint,
        prefixIcon:widget.leading==null?null:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SvgPicture.string(widget.leading!,
              fit: BoxFit.scaleDown),
        ) ,
            suffixIcon: widget.isPassword??false ?InkWell(onTap:(){setState(() {
              obs=!obs;
              icon=obs?APPSVG.visibleIcon:APPSVG.invisibleIcon;
              
            });}, child:SvgPicture.string(icon,fit: BoxFit.scaleDown, )):null,
          
    ));
  }
}