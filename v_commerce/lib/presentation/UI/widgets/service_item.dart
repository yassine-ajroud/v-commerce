import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';

class ServiceItem extends StatelessWidget {
 final String? image;
  final String firstName;
  final String lastName;
  final String address;
  const ServiceItem({super.key,required this.image,required this.firstName,required this.lastName,required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:0.0,vertical: 5),
      child: SizedBox(
        height: 250.h,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child:image==null?
            Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 4,color: AppColors.extraLightBlueColor)
                        ),
                        width: double.infinity,
                        height: 200.h,
                        child: SvgPicture.string(APPSVG.imagePlaceHolderIcon,fit: BoxFit.scaleDown,)) :
            Image.network(image!,height: 200.h,width:double.infinity , fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 5),
              child: Text('$firstName $lastName',style: AppTextStyle.blackTextStyle,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Text(address,style: AppTextStyle.smallblackTextStyle,),
            ),
        ]),),
    );
  }
}