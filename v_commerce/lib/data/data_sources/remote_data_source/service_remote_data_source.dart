
import 'package:dio/dio.dart';
import 'package:v_commerce/core/errors/exceptions/exceptions.dart';
import 'package:v_commerce/core/utils/api_const.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/authentication_local_data_source.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/settings_local_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:v_commerce/data/models/service_model.dart';
import 'package:v_commerce/data/models/token_model.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getAllservices(String serviceCategory);
  Future<ServiceModel> addService(ServiceModel newService);
  Future<ServiceModel> getSingleService(String id);
  Future<ServiceModel> updateService(ServiceModel newService);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {

   Future<TokenModel>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
     Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

    Future<void> verifyToken () async {
      try{
      return await token.then((value) async{
      if(value.expiryDate.isBefore(DateTime.now())){
        final newToken =await AuthenticationRemoteDataSourceImpl().refreshToken(value.refreshToken,value.userId);
        await AuthenticationLocalDataSourceImpl().saveUserInformations(newToken);
      }
    });
      }catch(e){

      }
    
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
  Future<List<ServiceModel>> getAllservices(String serviceCategory) async {
    try {
      await verifyToken();
      final response = await dio.get(
        '${ApiConst.allService}/$serviceCategory',
     options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );
      List<dynamic> data = response.data;
      List<ServiceModel> services =
          data.map((e) => ServiceModel.fromJson(e)).toList();
      return services;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }

    @override
  Future<ServiceModel> addService(ServiceModel newService) async {
    try {
      final response = await dio.post(ApiConst.addService, data: newService.toJson(),);
      final data = response.data;
      return ServiceModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

    @override
  Future<ServiceModel> getSingleService(String id) async{
       try {
              await verifyToken();
      final response = await dio.get('${ApiConst.service}/$id',
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data;
      return ServiceModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  
    @override
  Future<ServiceModel> updateService(ServiceModel newService) async {
    try {
      await verifyToken();
      final response = await dio.put('${ApiConst.service}/${newService.id}', data: newService.toJson(),);
      final data = response.data;
      return ServiceModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
}
