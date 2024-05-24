import 'package:dartz/dartz.dart';
import 'package:v_commerce/domain/entities/service.dart';
import 'package:v_commerce/domain/repositories/service_repository.dart';
import '../../../core/errors/failures/failures.dart';

class AddServiceUsecase{
  final ServiceRepository repository;

  AddServiceUsecase(this.repository);

  Future<Either<Failure,MyService>> call(MyService newService)async=>await repository.addService(newService);
}