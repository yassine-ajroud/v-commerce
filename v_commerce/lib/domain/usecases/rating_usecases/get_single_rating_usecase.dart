import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/rating.dart';
import 'package:v_commerce/domain/repositories/rating_repository.dart';

class GetSingleRatingUsecase {
  final RatingRepository _repository;

  GetSingleRatingUsecase(this._repository);

  Future<Either<Failure, SimpleRating>> call(String ratingID) async => await _repository.getSingleRating(ratingID);
}
