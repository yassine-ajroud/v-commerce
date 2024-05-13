import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/review_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/review.dart';

class AddReviewUsecase {
  final ReviewRepository _repository;

 const AddReviewUsecase(this._repository);

  Future<Either<Failure, Review>> call(Review review) async=>
      await _repository.addReview(review);
}
