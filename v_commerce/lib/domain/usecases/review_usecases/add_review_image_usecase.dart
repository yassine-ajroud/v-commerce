import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/review_repository.dart';

import '../../../core/errors/failures/failures.dart';

class AddReviewImageUsecase {
  final ReviewRepository _repository;

 const AddReviewImageUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String reviewId,required File file}) async=>
      await _repository.addReviewImage(reviewId: reviewId,file: file);
}
