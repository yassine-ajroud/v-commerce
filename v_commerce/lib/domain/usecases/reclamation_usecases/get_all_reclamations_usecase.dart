import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/reclamation.dart';
import 'package:v_commerce/domain/repositories/reclamation_repository.dart';

class GetAllReclamationsUsecase {
  final ReclamationRepository _repository;

 const GetAllReclamationsUsecase(this._repository);

  Future<Either<Failure, List<Reclamation>>> call(String userID) async =>
      await _repository.getAllReclamations(userID);
}
