import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';

import 'package:v_commerce/domain/repositories/rating_repository.dart';

class DeleteRatingUsecase {
  final RatingRepository _repository;

  DeleteRatingUsecase(this._repository);

  Future<Either<Failure, Unit>> call(String ratingID) async => await _repository.deleteRating(ratingID);
}
