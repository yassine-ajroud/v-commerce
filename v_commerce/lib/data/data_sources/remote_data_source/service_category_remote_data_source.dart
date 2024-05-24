
import 'package:dio/dio.dart';
import 'package:v_commerce/core/errors/exceptions/exceptions.dart';
import 'package:v_commerce/core/utils/api_const.dart';
import 'package:v_commerce/data/models/service_category_model.dart';

abstract class ServiceCategoryRemoteDataSource {
  Future<List<ServiceCategoryModel>> getAllServiceCategories();
}

class ServiceCategoryRemoteDataSourceImpl implements ServiceCategoryRemoteDataSource {

   final dio = Dio(BaseOptions(
  baseUrl: ApiConst.baseUrl,
  contentType: Headers.jsonContentType,
  validateStatus: (int? status) {
    return status != null;
    // return status != null && status >= 200 && status < 300;
  },
));

  @override
  Future<List<ServiceCategoryModel>> getAllServiceCategories() async {
    try {
      final response = await dio.get(
        ApiConst.serviceCategory,
      );
      List<dynamic> data = response.data;
      List<ServiceCategoryModel> serviceCategories =
          data.map((e) => ServiceCategoryModel.fromJson(e)).toList();
      return serviceCategories;
    } on DioException catch (e) {
      print(e);
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }
}
