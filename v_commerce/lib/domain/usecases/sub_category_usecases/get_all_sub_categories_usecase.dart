import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/sub_catergory.dart';
import 'package:v_commerce/domain/repositories/sub_category_repository.dart';

import '../../../core/errors/failures/failures.dart';

class GetAllSubCategoriesUsecase {
  final SubCategoryRepository repository;

  GetAllSubCategoriesUsecase(this.repository);

  Future<Either<Failure, List<SubCategory>>> call() async =>
      await repository.getAllSubCategories();
}
