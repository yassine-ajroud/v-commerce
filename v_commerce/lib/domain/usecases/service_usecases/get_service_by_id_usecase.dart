
import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/service.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class GetServiceByIdUsecase{
  final ServiceRepository repository;

  GetServiceByIdUsecase(this.repository);

  Future<Either<Failure,MyService>> call(String serviceId)async=>await repository.getServiceById(serviceId);
}