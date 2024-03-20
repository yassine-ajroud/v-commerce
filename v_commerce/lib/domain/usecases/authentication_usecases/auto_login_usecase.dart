import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/authentication_repository.dart';


import '../../../core/errors/failures/failures.dart';
import '../../entities/token.dart';


class AutoLoginUsecase {
  final AuthenticationRepository repository;

  const AutoLoginUsecase(this.repository);
  Future<Either<Failure, Token>> call() async => await repository.autologin();
}
