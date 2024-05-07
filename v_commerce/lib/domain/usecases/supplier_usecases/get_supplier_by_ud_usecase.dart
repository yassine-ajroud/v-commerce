import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/supplier.dart';
import 'package:v_commerce/domain/repositories/supplier_repository.dart';

import '../../../core/errors/failures/failures.dart';

class GetSupplierByIdUsecase {
  final SupplierRepository repository;

  GetSupplierByIdUsecase(this.repository);

  Future<Either<Failure, Supplier>> call(String supplierId) async =>
      await repository.getSupplierById(supplierId:supplierId);
}
