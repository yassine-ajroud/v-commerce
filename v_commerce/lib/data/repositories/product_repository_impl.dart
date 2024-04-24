import 'package:dartz/dartz.dart';
import 'package:v_commerce/core/errors/exceptions/exceptions.dart';
import 'package:v_commerce/core/errors/failures/failures.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:v_commerce/domain/entities/product.dart';
import 'package:v_commerce/domain/repositories/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  const ProductRepositoryImp(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final productModels = await productRemoteDataSource.getAllProducts();
      final products = productModels
          .map((e) => Product(
              id: e.id,
              reference: e.reference,
              dimensions:e.dimensions,
              provider: e.provider,
              category: e.category,
              name: e.name,
              description: e.description,
              price: e.price,
              rate: e.rate,
              promotion: e.promotion,
              sales: e.sales,
              subCategory: e.subCategory,
              image: e.image,
              materials: e.materials,
              ))
          .toList();
      return right(products);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById({ required String productId}) async {
    try {
      final product =
          await productRemoteDataSource.getOneProducts(id: productId);
      return right(product);
  } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory({
     required String category}) async {
    try {
      final productModels = await productRemoteDataSource.getProductsByCategory(
          category: category);

      return right(productModels);
  } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsBySubCategory({required String category,
      required String subCategory}) async{
     try {
      final productModels = await productRemoteDataSource.getProductsBySubCategory(
          category: category,subCategory: subCategory);
      final products = productModels
          .map((e) => Product(
               id: e.id,
              reference: e.reference,
              dimensions:e.dimensions,
              provider: e.provider,
              category: e.category,
              name: e.name,
              description: e.description,
              price: e.price,
              rate: e.rate,
              promotion: e.promotion,
              sales: e.sales,
              subCategory: e.subCategory,
              image: e.image,
              materials: e.materials,))
          .toList();
      return right(products);
} on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

}
