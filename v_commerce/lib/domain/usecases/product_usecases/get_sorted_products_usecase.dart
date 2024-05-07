import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/product_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/product.dart';

class GetSortedProductsUsecase {
  final ProductRepository repository;

  GetSortedProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call() async =>
      await repository.getSortedProducts();
}
