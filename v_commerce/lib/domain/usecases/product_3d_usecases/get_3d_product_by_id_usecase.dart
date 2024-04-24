import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/product3d.dart';
import 'package:v_commerce/domain/repositories/product3d_repository.dart';


class Get3DProductsByIdUseCase {
  final Product3DRepository _repository;

  const Get3DProductsByIdUseCase(this._repository);

  Future<Either<Failure, Product3D>> call(String productid) async =>
      await _repository.getOne3DProduct(productid);
}
