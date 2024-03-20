import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/token.dart';
import '../../repositories/authentication_repository.dart';


class GoogleLoginUsecase {
  final AuthenticationRepository repository;

  const GoogleLoginUsecase(this.repository);
  Future<Either<Failure, Token>> call() async => await repository.googleLogin();
}
