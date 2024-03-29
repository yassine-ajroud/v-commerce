import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderBox extends StatelessWidget {
  IconData icon;
  Color color;

  GenderBox(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:90.h,
      width: 90.w,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: color),
          borderRadius: BorderRadius.circular(15)),
      child:  Icon(
        icon,
        size: 50,
        color: color,
      ),
    );
  }
}