import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/exceptions/exceptions.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/service_category_remote_data_source.dart';
import 'package:v_commerce/domain/entities/service_category.dart';
import 'package:v_commerce/domain/repositories/service_category_repository.dart';

class ServiceCategoryRepositoryImpl implements ServiceCategoryRepository {
  final ServiceCategoryRemoteDataSource serviceCategoryRemoteDataSource;

  const ServiceCategoryRepositoryImpl(this.serviceCategoryRemoteDataSource);

  @override
  Future<Either<Failure, List<ServiceCategory>>> getAllServiceCategories() async {
    try {
      final serviceCategoryModels = await serviceCategoryRemoteDataSource.getAllServiceCategories();
      return right(serviceCategoryModels);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  
 

  
}
