import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class GetAllServicesUsecase{
  final ServiceRepository repository;

  GetAllServicesUsecase(this.repository);

  Future<Either<Failure,List<Service>>> call(String serviceCategoryId)async=>await repository.getAllServices(serviceCategoryId);
}