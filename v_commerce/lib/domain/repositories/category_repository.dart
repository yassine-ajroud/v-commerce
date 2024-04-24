import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';

import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
