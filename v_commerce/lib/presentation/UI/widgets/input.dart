import 'package:flutter/material.dart';

import '../../../core/styles/colors.dart';

// ignore: must_be_immutable
class InputText extends StatefulWidget {
  final String hint;
   bool ? isPassword;
  // Icon ? icon;
  final String? Function(String?)? validator;
  final TextEditingController? controler;
  final int ? length;
  final TextInputType ? type ;
   InputText({super.key, required this.hint,this.isPassword,this.type,this.controler,this.validator,this.length});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
 late bool obs;
 late Icon icon ;
  @override
  void initState() {
    obs=widget.isPassword??false;
    icon =const Icon(Icons.visibility);
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
        hintText:widget.hint,
            suffixIcon: widget.isPassword??false ?InkWell(onTap:(){setState(() {
              obs=!obs;
              icon=Icon(obs?Icons.visibility:Icons.visibility_off);
            });}, child:icon):null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:const BorderSide(color: AppColors.black,
              width: 2.0)
            ),
            enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.black,
                    width: 2.0,
                  ),
          ),
    ));
  }
}