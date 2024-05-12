import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/rating.dart';
import 'package:v_commerce/domain/repositories/rating_repository.dart';


class AddRatingUsecase {
  final RatingRepository _repository;

  AddRatingUsecase(this._repository);

  Future<Either<Failure, SimpleRating>> call(SimpleRating rating) async => await _repository.addRating(rating);
}
