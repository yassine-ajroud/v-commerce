import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class DeleteServiceUsecase{
  final ServiceRepository repository;

  DeleteServiceUsecase(this.repository);

  Future<Either<Failure,Unit>> call(String serviceId)async=>await repository.deleteService(serviceId);
}