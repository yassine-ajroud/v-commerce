import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';

class GenderBox extends StatefulWidget {
 final IconData icon;
 final bool isMale;

 const GenderBox({super.key, required this.icon ,required this.isMale});

  @override
  State<GenderBox> createState() => _GenderBoxState();
}
late AuthenticationController controller;

class _GenderBoxState extends State<GenderBox> {
  @override
  void initState() {
    controller = Get.find();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.setGender(widget.isMale?'male':'female');
      },
      child: Container(
        height:90.h,
        width: 90.w,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color:(widget.isMale&&controller.gender=='male') || (!widget.isMale&&controller.gender=='female')?AppColors.primary:AppColors.black),
            borderRadius: BorderRadius.circular(15)),
        child:  Icon(
          widget.icon,
          size: 50,
          color: (widget.isMale&&controller.gender=='male') || (!widget.isMale&&controller.gender=='female')?AppColors.primary:AppColors.black,
        ),
      ),
    );
  }
}