import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/reclamation.dart';
import 'package:v_commerce/domain/repositories/reclamation_repository.dart';

class GetSingleReclamationUsecase {
  final ReclamationRepository _repository;

  const GetSingleReclamationUsecase(this._repository);

  Future<Either<Failure,Reclamation>> call(String reclamationID) async =>
      await _repository.getSingleReclamation(reclamationID);
}
