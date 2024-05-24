import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class AddServiceUsecase{
  final ServiceRepository repository;

  AddServiceUsecase(this.repository);

  Future<Either<Failure,Unit>> call(Service newService)async=>await repository.addService(newService);
}