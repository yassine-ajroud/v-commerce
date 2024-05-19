import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/reclamation.dart';
import 'package:v_commerce/domain/repositories/reclamation_repository.dart';


class AddReclamationsUsecase {
  final ReclamationRepository _repository;

 const AddReclamationsUsecase(this._repository);

  Future<Either<Failure, Unit>> call(Reclamation newReclamation) async =>
      await _repository.addReclamation(newReclamation);
}
