import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/UI/widgets/review_item.dart';
import 'package:v_commerce/presentation/controllers/rating_controller.dart';
import 'package:v_commerce/presentation/controllers/review_controller.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RatingController ratingController = Get.find();
    return SafeArea(child: Scaffold(
      body: GetBuilder(
        init: ReviewController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getProductReviews(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                print('snapshot ${snapshot.data}');
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
          
                            snapshot.data!.length>0?  SliverList.builder(
                                itemCount:  snapshot.data!.length,
                                itemBuilder: (_,index)=>ReviewItem(review:  snapshot.data![index], userRate: ratingController.getUserRating(snapshot.data![index].productID, snapshot.data![index].userID))):
                                     const  SliverToBoxAdapter(
                            child: Center(child: Text("Empty reviews")),
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