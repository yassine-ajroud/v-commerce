import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/date.dart';
import 'package:v_commerce/presentation/UI/widgets/comment_input.dart';
import 'package:v_commerce/presentation/UI/widgets/review_item.dart';
import 'package:v_commerce/presentation/controllers/rating_controller.dart';
import 'package:v_commerce/presentation/controllers/review_controller.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RatingController ratingController = Get.find();
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: const CommentInput(),
      body: GetBuilder(
        init: ReviewController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getProductReviews(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
 return CustomScrollView(
                slivers: [
                    SliverAppBar(
                            automaticallyImplyLeading: false,
                            leading:IconButton(
                              onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            padding: EdgeInsets.zero,
                            icon:const Icon(Icons.arrow_back,size: 30,)) ,
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                           shadowColor: Colors.grey,
                              pinned: true,
                              floating: true,
                              snap: true,
                                  
                          ),  
          
                        controller.allreviews.isNotEmpty?  SliverList.builder(
                          
                                itemCount:   controller.allreviews.length,
                                itemBuilder: (_,index)=>ReviewItem(review:   controller.allreviews[index], userRate: ratingController.getUserRating( controller.allreviews[index].productID,  controller.allreviews[index].userID),date:DateParser.getDateDifference( controller.allreviews[index].date!).toString(),lastItem: index==  controller.allreviews.length-1,)):
                                     const  SliverToBoxAdapter(
                            child: Center(child: Text("Empty reviews")),
                          ),
                                   const  SliverToBoxAdapter(
                    child: SizedBox(height: 90),
                  )
                ],
              );
              }else if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }else{
                return Text("no reviews");
              }

             
            }
          );
        }
      ),
    ));
  }
}