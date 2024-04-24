import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/product_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/product.dart';

class GetProductsByCategoryUsecase {
  final ProductRepository repository;

  GetProductsByCategoryUsecase(this.repository);

  Future<Either<Failure,  List<Product>>> call(String category) async =>
      await repository.getProductsByCategory(category:category);
}
