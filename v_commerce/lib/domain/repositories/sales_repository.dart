import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/sales.dart';

abstract class SalesRepository{
  Future<Either<Failure,List<Sales>>> getAllSales(String userId);
  Future<Either<Failure,Sales>> getSingleSale(String saleId);
  Future<Either<Failure,Sales>> addSale(Sales newSale);
  Future<Either<Failure,Unit>> deleteSale(String saleId);
  Future<Either<Failure,Unit>> updateSale(Sales sale);
}