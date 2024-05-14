import 'package:get/get.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/review.dart';
import 'package:v_commerce/domain/usecases/review_usecases/get_all_reviews_usecase.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';

class ReviewController extends GetxController{

Future<List<Review>> getProductReviews()async{
  List<Review> allreviews=[];
  ProductController productController=Get.find();
  final res =await GetAllReviewsUsecase(sl())(productController.currentProductid);
  res.fold((l) => null, (r) => allreviews=r);
  print('reviews $allreviews');
  return allreviews;
}
}