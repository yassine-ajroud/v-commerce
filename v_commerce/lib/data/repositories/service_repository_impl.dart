import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/exceptions/exceptions.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/service_remote_data_source.dart';
import 'package:v_commerce/data/models/service_model.dart';
import 'package:v_commerce/domain/entities/service.dart';

import '../../domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource serviceRemoteDataSource;

  const ServiceRepositoryImpl(this.serviceRemoteDataSource);

  @override
  Future<Either<Failure, MyService>> addService(MyService newService) async{
     try {
      ServiceModel myService= ServiceModel(service: newService.service, description: newService.description, experience: newService.experience, images: newService.images, userId: newService.userId);
      final serviceModel = await serviceRemoteDataSource.addService(myService);
      return right(serviceModel);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addServiceImage(String serviceId, File file) async{
        try {
      await serviceRemoteDataSource.uploadServiceImage(serviceId,file);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteService(String serviceId) {
    // TODO: implement deleteService
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MyService>>> getAllServices(String serviceCategoryId) async{
   try {
      final serviceModels = await serviceRemoteDataSource.getAllservices(serviceCategoryId);
      return right(serviceModels);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, MyService>> getServiceById(String serviceId)async {
   try {
      final serviceModels = await serviceRemoteDataSource.getSingleService(serviceId);
      return right(serviceModels);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, MyService>> updateService(MyService newService)async {
      try {
      ServiceModel myService= ServiceModel(service: newService.service, description: newService.description, experience: newService.experience, images: newService.images, userId: newService.userId,id: newService.id);
      final serviceModel = await serviceRemoteDataSource.updateService(myService);
      return right(serviceModel);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateServiceImage(String serviceId,File file, String oldImage) async{
        try {
      await serviceRemoteDataSource.updateServiceImage(serviceId,file,oldImage);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, MyService>> getServiceByUserId(String userId) async{
    try {
      final serviceModels = await serviceRemoteDataSource.getUserService(userId);
      return right(serviceModels);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  
 

  
}
