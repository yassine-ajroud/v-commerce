import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/sub_catergory.dart';

abstract class SubCategoryRepository {
  Future<Either<Failure, List<SubCategory>>> getAllSubCategories();
}
