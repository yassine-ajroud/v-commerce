import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/service.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<MyService>>> getAllServices(String serviceCategoryId);
  Future<Either<Failure, MyService>> getServiceById(String serviceId);
  Future<Either<Failure, MyService>> getServiceByUserId(String userId);
  Future<Either<Failure, MyService>> addService(MyService newService);
  Future<Either<Failure, MyService>> updateService(MyService newService);
  Future<Either<Failure, Unit>> deleteService(String serviceId);
  Future<Either<Failure, Unit>> addServiceImage(String serviceId,File file);
  Future<Either<Failure, Unit>> updateServiceImage(String serviceId,File file ,String oldImage);

}
