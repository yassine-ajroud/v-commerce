import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/service_category.dart';
import 'package:v_commerce/domain/repositories/service_category_repository.dart';

import '../../../core/errors/failures/failures.dart';

class GetAllServiceCategoriesUsecase {
  final ServiceCategoryRepository repository;

  GetAllServiceCategoriesUsecase(this.repository);

  Future<Either<Failure, List<ServiceCategory>>> call() async =>
      await repository.getAllServiceCategories();
}
