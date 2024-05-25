import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';

import '../../../core/errors/failures/failures.dart';

class UpdateServiceImageUsecase {
  final ServiceRepository _repository;

 const UpdateServiceImageUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String serviceId,required File file,required String oldImage}) async=>
      await _repository.updateServiceImage(serviceId, file,oldImage);
}
