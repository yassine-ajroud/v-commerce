import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/service_category.dart';

abstract class ServiceCategoryRepository {
  Future<Either<Failure, List<ServiceCategory>>> getAllServiceCategories();
}
