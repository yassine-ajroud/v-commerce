import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class UpdateServiceUsecase{
  final ServiceRepository repository;

  UpdateServiceUsecase(this.repository);

  Future<Either<Failure,Service>> call(Service newService)async=>await repository.updateService(newService);
}