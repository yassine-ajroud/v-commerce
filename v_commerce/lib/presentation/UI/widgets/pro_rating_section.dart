import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/presentation/UI/widgets/rate_progress_widget.dart';

class ProfessionalRatingSection extends StatelessWidget {
  final double politesse,cout,qualite,ponctualite;
  const ProfessionalRatingSection({super.key,required this.cout,required this.politesse,required this.ponctualite,required this.qualite});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
                      height: 130.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                       RateProgressWidget(color: AppColors.primary,value:politesse,label: 'Politesse',width: 190.w,trailing: Text.rich( TextSpan(children:[TextSpan(text:(politesse/5).toString(),style: AppTextStyle.hintTextStyle),const WidgetSpan(child: Icon(Icons.star_border_outlined,color: AppColors.black,size: 15,),alignment: PlaceholderAlignment.middle,) ]),textAlign: TextAlign.center,),),
                       RateProgressWidget(color: AppColors.primary,value:qualite,label: 'Qualité',width: 190.w,trailing: Text.rich( TextSpan(children:[TextSpan(text:(qualite/5).toString(),style: AppTextStyle.hintTextStyle),const WidgetSpan(child: Icon(Icons.star_border_outlined,color: AppColors.black ,size: 15,),alignment: PlaceholderAlignment.middle,) ]),textAlign: TextAlign.center,),),
                        RateProgressWidget(color: AppColors.primary,value:cout,label: 'Cout',width: 190.w,trailing: Text.rich( TextSpan(children:[TextSpan(text:(cout/5).toString(),style: AppTextStyle.hintTextStyle),const WidgetSpan(child: Icon(Icons.star_border_outlined,color: AppColors.black,size: 15,),alignment: PlaceholderAlignment.middle,) ]),textAlign: TextAlign.center,),),
                          RateProgressWidget(color: AppColors.primary,value:ponctualite,label: 'Ponctualité',width: 190.w,trailing: Text.rich( TextSpan(children:[TextSpan(text:(ponctualite/5).toString(),style: AppTextStyle.hintTextStyle),const WidgetSpan(child: Icon(Icons.star_border_outlined,color: AppColors.black,size: 15,),alignment: PlaceholderAlignment.middle,) ]),textAlign: TextAlign.center,),),
                        ],),
                       
                       
                       
                    );
  }
}