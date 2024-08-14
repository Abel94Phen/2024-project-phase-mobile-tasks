import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_sources.dart';
import '../data_sources/product_remote_data_sources.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository{

  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, void>> createProduct(Product product) async{
    
    if (await networkInfo.isConnected){
      try {
        await productRemoteDataSource.createProduct(ProductModel.toModel(product));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async{
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.deleteProduct(productId);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.getAllProducts();
        await productLocalDataSource.cacheAllProducts(result);

        return Right(ProductModel.toEntityList(result));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await productLocalDataSource.getAllProducts();
        return Right(ProductModel.toEntityList(result));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        return (Right(
          await productRemoteDataSource.getSingleProduct(productId)
        ));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.updateProduct(ProductModel.toModel(product));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}