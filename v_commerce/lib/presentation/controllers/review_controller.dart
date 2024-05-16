import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/review.dart';
import 'package:v_commerce/domain/usecases/review_usecases/add_review_image_usecase.dart';
import 'package:v_commerce/domain/usecases/review_usecases/add_review_usecase.dart';
import 'package:v_commerce/domain/usecases/review_usecases/get_all_reviews_usecase.dart';
import 'package:v_commerce/domain/usecases/review_usecases/remove_review.dart';
import 'package:v_commerce/domain/usecases/review_usecases/update_review_usecase.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';

class ReviewController extends GetxController{
 XFile? img,updateimg;
  File? f,updatef;
  final ImagePicker _picker = ImagePicker();
  String fileName = '';
  String comment = '';
    String updatecomment = '';
   final TextEditingController updateeditingController=TextEditingController();
   final TextEditingController editingController=TextEditingController();
  List<Review> allreviews=[]; 


Future<List<Review>> getProductReviews()async{
  ProductController productController=Get.find();
  final res =await GetAllReviewsUsecase(sl())(productController.currentProductid);
  res.fold((l) => null, (r) => allreviews=r);
  return allreviews;
}

  void typeComment(String s) {
    comment = s;
    update();
  }

  Future<void> pickImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(
              'Upload image',
              style: AppTextStyle.blackTitleTextStyle,
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () async {
                          img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            f = File(img!.path);
                            fileName = basename(f!.path);
                          update();
                          }
                         
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.image,
                          size: 40,
                          color: AppColors.secondary,
                        )),
                    IconButton(
                        onPressed: () async {
                          img = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (img != null) {
                            f = File(img!.path);
                            fileName = basename(f!.path);
                          update();
                          }
                          
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.secondary,
                        )),
                  ]),
            ),
          ),
        );
      },
    );
  }

    //Clear image
  void clearImage() {
    f = null;
    img = null;
    fileName = '';
    update();
  }

  Future<void> addReview()async{
    AuthenticationController authenticationController=Get.find();
    ProductController productController=Get.find();

     await AddReviewUsecase(sl())
                                          .call(Review(
                                              id: null,
                                              userID: authenticationController.currentUser.id!,
                                              productID: productController.currentProductid,
                                              comment: comment.trim(),
                                              image: fileName))
                                          .then((value) async{
                                            if(f!=null){
                                           value.fold((l) => null, (r)async =>await AddReviewImageUsecase(sl())(reviewId: r.id!,file: f!) );
                                            }
                                        comment='';
                                        clearImage();
                                          await getProductReviews();
                                        editingController.clear();
                                                                             update();

                                     });

  }

    Future<void> deletComment(String commentID) async {
    final deleteRes = await RemoveReviewUsecase(sl()).call(commentID);
    deleteRes.fold((l) => null, (r)async {
     await getProductReviews();
      update();
    });
  }

 Future<void> updateReview(Review newReview,BuildContext context)async{
  updatecomment=newReview.comment;
  String updatefileName=newReview.image??'';
  updateeditingController.text=newReview.comment;
          print('update file $updatefileName');

  showDialog(
    context: context,
    builder:(_)=> AlertDialog(
          title: Text(
            'Update Comment',
           // style: AppTextStyle.subTitleTextStyle,
          ),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Upload image',
                                  //style: AppTextStyle.subTitleTextStyle,
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              updateimg = await _picker.pickImage(
                                                  source: ImageSource.gallery);
                                              if (updateimg != null) {
                                                  updatef = File(updateimg!.path);
                                                  updatefileName = basename(updatef!.path);
                                              }
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.image,
                                              size: 40,
                                              color: AppColors.secondary,
                                            )),
                                        IconButton(
                                            onPressed: () async {
                                              updateimg = await _picker.pickImage(
                                                  source: ImageSource.camera);
                                              if (updateimg != null) {
                                                
                                                   updatef = File(updateimg!.path);
                                                   updatefileName = basename(updatef!.path);
                                                                                              print('update file reset 2 $fileName');

                                              }
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              size: 40,
                                              color: AppColors.secondary,
                                            )),
                                      ]),
                                ),
                              );
                            });
                      },
                      child: updatef != null
                          ? Stack(children: [
                              Image.file(updatef!),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                       
                                         // newReview.image = '';
                                          updatef = null;
                                          updateimg = null;
                                          updatefileName = "x";
                                                                                        print('update file reset 1 $updatefileName');

                                      },
                                      icon: const Icon(Icons.clear)))
                            ])
                          : updatefileName == "x"
                              ?  SvgPicture.string(APPSVG.pickImageIcon,color: AppColors.darkGrey,width: 100,)
                              : Stack(
                                  children: [
                                    Image.network(
                                        newReview.image!),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () {
                                                updatefileName = 'x';
                                                                                              print('update file reset $updatefileName');

                                            },
                                            icon: const Icon(Icons.clear)))
                                  ],
                                ),
                      // onTap: ,
                    ),
                    TextField(
                      onChanged: (s) {
                     updatecomment = s;
                      },
                      minLines: 1,
                      maxLines: 3,
                     controller: updateeditingController,
                      decoration: const InputDecoration(
                        hintText: "write your comment",
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),

MyButton(text: "Update", click: ()async{
      if (updatecomment != '') {
        print('update file $updatefileName');
                            newReview.comment = updatecomment;
                            if(updatefileName=='x'){
                              print('empty file');
                              newReview.image='';
                            }
                            await UpdateReviewUsecase(sl())(newReview)
                                .then((value) async {
                                  if(updatef!=null){
                                     return await AddReviewImageUsecase(sl())(reviewId: newReview.id!,file: updatef!);
                                  }
                                 
                                });
                                update();
                                Navigator.of(context).pop();
                          }
}),
                                 
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancel'))
                  ],
                ),
              )),
        ),
  );
    
 } 
}