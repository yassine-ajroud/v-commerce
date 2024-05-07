import 'package:dio/dio.dart';
import 'package:v_commerce/core/utils/api_const.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/authentication_local_data_source.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/settings_local_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:v_commerce/data/models/supplier_model.dart';
import 'package:v_commerce/data/models/token_model.dart';

import '../../../core/errors/exceptions/exceptions.dart';

abstract class SupplierRemoteDataSource {
  Future<SupplierModel> getSupplierById(String id);
}

class SupplierRemoteDataSourceImpl implements SupplierRemoteDataSource{
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
  Future<SupplierModel> getSupplierById(String id) async{
       try {
              await verifyToken();
      final response = await dio.get("${ApiConst.supplier}/$id",
        options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data;
      return  SupplierModel.fromJson(data);
    }on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }

}