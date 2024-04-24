import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/product3d.dart';
import 'package:v_commerce/domain/repositories/product3d_repository.dart';


class GetAll3DProductsUseCase {
  final Product3DRepository _repository;

  const GetAll3DProductsUseCase(this._repository);

  Future<Either<Failure, List<Product3D>>> call(String product) async =>
      await _repository.getAll3DProducts(product);
}
