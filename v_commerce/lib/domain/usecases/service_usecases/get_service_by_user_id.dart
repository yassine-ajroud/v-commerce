
import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/service.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class GetServiceByUserIdUsecase{
  final ServiceRepository repository;

  GetServiceByUserIdUsecase(this.repository);

  Future<Either<Failure,MyService>> call(String userId)async=>await repository.getServiceByUserId(userId);
}