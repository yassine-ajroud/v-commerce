import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';

// ignore: must_be_immutable
class DescriptionInput extends StatefulWidget {
 final String hint;
  final String? leading; 
  final String? Function(String?)? validator;
  final TextEditingController? controler;
const   DescriptionInput({super.key, required this.hint,this.controler,this.validator, this.leading});

  @override
  State<DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<DescriptionInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
     
      validator: widget.validator,
      controller: widget.controler,
      minLines: 1,
      maxLines: 5,
    keyboardType:  TextInputType.text,
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
           
          
    ));
  }
}