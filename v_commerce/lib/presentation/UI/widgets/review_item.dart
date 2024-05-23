import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/domain/entities/review.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/review_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  final int userRate;
  final String date;
  final bool lastItem;
  const ReviewItem({super.key,required this.review,required this.userRate,required this.date,required this.lastItem});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController=Get.find();
    return GetBuilder(
      init: ReviewController(),
      builder: (controller) {
        return PopupMenuButton(
           onSelected: (value) async {
                                switch (value) {
                                  case "/update":
                                  controller.updateReview(review, context);
                                    break;
                                  case "/delete":
                                    await controller.deletComment(
                                        review.id!);
                                    break;
                                }
                              },
                              enableFeedback: true,
                              enabled: review.userID ==
                                 authenticationController.currentUser.id,
                              itemBuilder: ((context) =>  [
                                    PopupMenuItem(
                                      value: "/update",
                                      child: Text(AppLocalizations.of(context)!.edit),
                                    ),
                                    PopupMenuItem(
                                        value: "/delete", child: Text(AppLocalizations.of(context)!.delete))]),
          child: Column(children: [
            FutureBuilder(
              future: authenticationController.getUserById(review.userID),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                return ListTile(
                    leading:snapshot.data!.image==""?const CircleAvatar(backgroundColor: AppColors.grey,) :CircleAvatar(backgroundImage:NetworkImage( snapshot.data!.image!),),
                    title: Text('${snapshot.data!.firstName} ${snapshot.data!.lastName}',style: AppTextStyle.smallblackTextStyle,),
                    subtitle:  Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(5, (index) => Icon(index<userRate? Icons.star: Icons.star_border,
                              size: 20,
                                      color: AppColors.secondary,)),),
        
                                      trailing: Text(date,style: AppTextStyle.smallGreyTextStyle,),
                );
                }return const CircularProgressIndicator();
        
                
              }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightgrey,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(review.comment,style: AppTextStyle.smallblackTextStyle,),
                )),
            ),
            review.image=='' ||  review.image==null?Container():  Padding(
                  padding:  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(review.image!,width:double.infinity ,height: 200.h,fit: BoxFit.cover,)),
                ),
            lastItem?Container(): const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  child:  Divider(),
                )
          ],),
        );
      }
    );

  }
}