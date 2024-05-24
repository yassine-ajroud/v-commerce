import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Service>>> getAllServices(String serviceCategoryId);
  Future<Either<Failure, Service>> getServiceById(String serviceId);
  Future<Either<Failure, Unit>> addService(Service newService);
  Future<Either<Failure, Service>> updateService(Service newService);
  Future<Either<Failure, Unit>> deleteService(String serviceId);

  Future<Either<Failure, Unit>> addServiceImage(File image);
  Future<Either<Failure, Unit>> updateServiceImage(File image,String oldImage);

}
