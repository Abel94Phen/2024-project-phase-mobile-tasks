import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_sources.dart';
import '../data_sources/product_remote_data_sources.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl extends ProductRepository{
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.createProduct(ProductModel.toModel(product));
        return Right(result.toProduct());
      } on ServerException {
        return const Left(ServerFailure(ErrorMessages.serverError));
      } on SocketException {
        return const Left(ConnectionFailure(ErrorMessages.noInternet));
      } catch(e){
        final errorMessage = e.toString();
        return Left(UnexpectedFailure(errorMessage));
      }
    } else {
        return const Left(ConnectionFailure(ErrorMessages.noInternet));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteProduct(productId);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(ErrorMessages.serverError));
      } on SocketException {
        return const Left(
            ConnectionFailure(ErrorMessages.noInternet));
      } catch (e) {
        final errorMessage = e.toString();
        return Left(UnexpectedFailure(errorMessage));
      }
    } else {
      return const Left(ConnectionFailure(ErrorMessages.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAllProducts();
        try {
          await localDataSource.cacheAllProducts(result);
        } on CacheException {
          debugPrint('Caching All Product Error');
        }
        return Right(ProductModel.toEntityList(result));
      } on ServerException {
        return const Left(ServerFailure(ErrorMessages.serverError));
      } on SocketException {
        return const Left(
            ConnectionFailure(ErrorMessages.noInternet));
      } catch (e) {
        final errorMessage = e.toString();
        return Left(UnexpectedFailure(errorMessage));
      }
    } else {
      try {
        
        final result = await localDataSource.getAllProducts();
        return Right(ProductModel.toEntityList(result));
      } on CacheException {
        return const Left(CacheFailure(ErrorMessages.cacheError));
      } catch (e) {
        final errorMessage = e.toString();
        return Left(UnexpectedFailure(errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getSingleProduct(productId);
        return Right(result.toProduct());
      } on ServerException {
        return const Left(ServerFailure(ErrorMessages.serverError));
      } on SocketException {
        return const Left(
            ConnectionFailure(ErrorMessages.noInternet));
      } catch (e) {
        final errorMessage = e.toString();
        return Left(UnexpectedFailure(errorMessage));
      }
    } else {
      return const Left(ConnectionFailure(ErrorMessages.noInternet));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.updateProduct(ProductModel.toModel(product));
        return Right(result.toProduct());
      } on ServerException {
        return const Left(ServerFailure(ErrorMessages.serverError));
      } on SocketException {
        return const Left(
            ConnectionFailure(ErrorMessages.noInternet));
      } catch (e) {
        final errorMessage = e.toString();
        return Left(UnexpectedFailure(errorMessage));
      }
    } else {
      return const Left(ConnectionFailure(ErrorMessages.noInternet));
    }
  }
}