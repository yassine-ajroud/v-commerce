import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/domain/entities/review.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key,required this.review});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController=Get.find();
    return Column(children: [
      FutureBuilder(
        future: authenticationController.getUserById(review.userID),
        builder: (context, snapshot) {
          if(snapshot.hasData){
          return ListTile(
              leading:snapshot.data!.image==""?CircleAvatar(backgroundColor: AppColors.grey,) :CircleAvatar(backgroundImage:NetworkImage( snapshot.data.image!),),
          );
          }return CircularProgressIndicator();

          
        }
      )
    ],);
  }
}