import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/supplier_remote_data_source.dart';
import 'package:v_commerce/domain/entities/supplier.dart';
import 'package:v_commerce/domain/repositories/supplier_repository.dart';


import '../../core/errors/exceptions/exceptions.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  SupplierRemoteDataSource supplierRemoteDataSource;
  SupplierRepositoryImpl(
     this.supplierRemoteDataSource,
  );


  @override
  Future<Either<Failure, Supplier>> getSupplierById({required String supplierId})async {
        try {
      final supplier =
          await supplierRemoteDataSource.getSupplierById(supplierId);
      return right(supplier);
  } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }
}
