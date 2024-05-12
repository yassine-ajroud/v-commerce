import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/rating.dart';
import 'package:v_commerce/domain/repositories/rating_repository.dart';

class UpdateRatingUsecase {
  final RatingRepository _repository;

  UpdateRatingUsecase(this._repository);

  Future<Either<Failure, SimpleRating>> call(SimpleRating newRating) async => await _repository.updateRating(newRating);
}
