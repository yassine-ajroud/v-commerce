import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                        children: [
                          Container(               
                            width: 150.w,
                            height: 170.h,
                            decoration: BoxDecoration(
                               color: Colors.blueAccent,
                               borderRadius: BorderRadius.circular(15)
                            ),
                            
                          ),
                           Positioned(
                            bottom:15,
                            right:15,
                             child: Container(               
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                 color: Colors.deepOrange,
                                 borderRadius: BorderRadius.circular(5)
                               ),child:const Icon(Icons.add,color: AppColors.white,),  ),
                           ),
                        ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) => Icon(index==4? Icons.star_half:Icons.star,size: 20,color: AppColors.secondary,)),),
                        ),

                           SizedBox(width: 145.w, child: Text('product name product name',style: AppTextStyle.smallBlackTitleTextStyle, overflow: TextOverflow.ellipsis,  maxLines: 1,
  softWrap: false,)),
                           Padding(
                                                       padding: const EdgeInsets.only(top:8.0),

                             child: Row(
                               children: [
                                 Text('20DT',style: AppTextStyle.priceTextStyle,),
                                const SizedBox(width: 10,),
                                 Text('30DT',style: AppTextStyle.oldPriceTextStyle,),
                               ],
                             ),
                           )

                      ],
                    )
                  );
  }
}