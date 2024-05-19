
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';


class CheckoutButton extends StatelessWidget {
  
  final void Function()? click;
  const CheckoutButton({super.key,required this.click});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 50.h,
        minHeight: 50.h,
        minWidth: 200.w,
        maxWidth: 200.w
      ),
               // width: 150.w,
                child: ElevatedButton(onPressed:click,style: ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.secondary),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                    side: const BorderSide(color :AppColors.secondary)
                  )
                )), child:        Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Checkout',style: AppTextStyle.buttonTextStyle),
       const   SizedBox(width: 10,),
        const  Icon(Icons.arrow_forward,color: AppColors.white,),
        ],
      )
                ),
              )


    ;
  }
}