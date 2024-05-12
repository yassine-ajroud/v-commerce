import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/presentation/UI/widgets/rate_progress_widget.dart';
import 'package:v_commerce/presentation/UI/widgets/rating_star_widget.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/rating_controller.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find();
    return GetBuilder<RatingController>(
      init:RatingController(),
      builder: (controller) {
        return FutureBuilder(
         future: controller.getRating(productController.currentProductid),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                             return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Rate the product",style: AppTextStyle.blackTitleTextStyle,),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical:25.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                    RatingStarWidget(index: 1),
                    RatingStarWidget(index: 2),
                    RatingStarWidget(index: 3),
                    RatingStarWidget(index: 4),
                    RatingStarWidget(index: 5)
                       ],
                   ),
                 ),
                 Row(
                  children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.extraLightBlueColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: 150.w,height: 130.h,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(TextSpan(children:[TextSpan(text: controller.productRating.avg.toString(),style: AppTextStyle.largeBlackTextStyle),TextSpan(text:'/5',style: AppTextStyle.blackTextStyle) ])),
                         const SizedBox(height: 5,),
                          Text('based on ${controller.productRating.number} rating',style: AppTextStyle.descriptionTextStyle,)
                        ],
                      ),
                    ),
                    ),
                    SizedBox(width: 20,),
                    SizedBox(
                      height: 130.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                                                RateProgressWidget(value:controller.productRating.number==0?0.0: controller.productRating.fiveStars/controller.productRating.number,label: '5 stars',),
                       RateProgressWidget(value:controller.productRating.number==0?0.0: controller.productRating.fourStars/controller.productRating.number,label: '4 star',),
                       RateProgressWidget(value:controller.productRating.number==0?0.0: controller.productRating.threeStars/controller.productRating.number,label: '3 stars',),
                        RateProgressWidget(value:controller.productRating.number==0?0.0: controller.productRating.twoStars/controller.productRating.number,label: '2 stars',),

                          RateProgressWidget(value:controller.productRating.number==0?0.0: controller.productRating.oneStar/controller.productRating.number,label: '1 star',),
                        ],),
                       
                       
                       
                    )
                 ],)
              ],
            );
                          }else{
                            return CircularProgressIndicator();
                          }

                          
                        
          
          }
        );
      }
    );
  }
}