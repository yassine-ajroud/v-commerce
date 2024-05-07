import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/supplier.dart';

import '../../core/errors/failures/failures.dart';

abstract class SupplierRepository {
  Future<Either<Failure,Supplier>> getSupplierById({required String supplierId});
}
