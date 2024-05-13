import 'package:dio/dio.dart';
import 'package:v_commerce/core/utils/api_const.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/authentication_local_data_source.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/settings_local_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:v_commerce/data/models/review_model.dart';
import 'package:v_commerce/data/models/token_model.dart';

import '../../../core/errors/exceptions/exceptions.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewModel> addReview(ReviewModel reviewModel);
  Future<List<ReviewModel>> getAllReviews(String prodId);
  Future<void> updateReview(ReviewModel review);
  Future<void> removeReview(String id);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
 Future<TokenModel>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
     Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

    Future<void> verifyToken () async {
     return await token.then((value) async{
      if(value.expiryDate.isBefore(DateTime.now())){
        final newToken =await AuthenticationRemoteDataSourceImpl().refreshToken(value.refreshToken,value.userId);
        await AuthenticationLocalDataSourceImpl().saveUserInformations(newToken);
      }
    });
  }

   final dio = Dio(BaseOptions(
  baseUrl: ApiConst.baseUrl,
  contentType: Headers.jsonContentType,
  validateStatus: (int? status) {
    return status != null;
    // return status != null && status >= 200 && status < 300;
  },
));

  @override
  Future<ReviewModel> addReview(ReviewModel review) async {
    try {
   final res = await dio.post("${ApiConst.products}/${review.productID}/reviews",
          data: review.toJson(),
            options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
        return ReviewModel.fromJson(res.data['review']);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ReviewModel>> getAllReviews(String prodId) async {
    try {
      final response = await dio.get("${ApiConst.products}/$prodId/reviews",
              options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      List<dynamic> data = response.data;
      List<ReviewModel> reviews =
          data.map((e) => ReviewModel.fromJson(e)).toList();
      return reviews;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> removeReview(String prodId) async {
    try {
      await dio.delete("${ApiConst.reviews}/$prodId",
              options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateReview(ReviewModel review) async {
    try {
      await dio.put("${ApiConst.reviews}/${review.id}",
          data: review.toJson(),
                  options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
      throw ServerException();
    }
  }
}
