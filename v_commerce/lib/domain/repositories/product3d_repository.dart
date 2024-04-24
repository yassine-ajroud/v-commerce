import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/product3d.dart';


abstract class Product3DRepository {
  Future<Either<Failure, List<Product3D>>> getAll3DProducts(String product);
  Future<Either<Failure, Product3D>> getOne3DProduct(String product3DId);
}
