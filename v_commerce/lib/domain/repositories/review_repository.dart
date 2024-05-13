import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';

import '../entities/review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, Review>> addReview(Review review);
  Future<Either<Failure, List<Review>>> getAllReviews(String prodId);
  Future<Either<Failure, Unit>> updateReview(Review review);
  Future<Either<Failure, Unit>> removeReview(String prodId);
}
