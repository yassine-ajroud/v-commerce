import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/service.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<MyService>>> getAllServices(String serviceCategoryId);
  Future<Either<Failure, MyService>> getServiceById(String serviceId);
  Future<Either<Failure, MyService>> addService(MyService newService);
  Future<Either<Failure, MyService>> updateService(MyService newService);
  Future<Either<Failure, Unit>> deleteService(String serviceId);
  Future<Either<Failure, Unit>> addServiceImage(File image);
  Future<Either<Failure, Unit>> updateServiceImage(File image,String oldImage);

}
