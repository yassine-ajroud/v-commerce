import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';

import '../../../core/errors/failures/failures.dart';

class AddServiceImageUsecase {
  final ServiceRepository _repository;

 const AddServiceImageUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String serviceId,required File file}) async=>
      await _repository.addServiceImage(serviceId, file);
}
