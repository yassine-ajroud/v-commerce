import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/domain/entities/rating.dart';
import 'package:v_commerce/domain/repositories/rating_repository.dart';

class GetRatingsUsecase {
  final RatingRepository _repository;

  GetRatingsUsecase(this._repository);

  Future<Either<Failure,ProductRating>> call(String productID) async=>await _repository.getRatings(productID);
}
