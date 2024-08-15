import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
 
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepository productRepository;

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSource();
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    
    productRepository(
        productRemoteDataSource: mockRemoteDataSource,
        productLocalDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  const testProductId = '1';
  const testProductModel = ProductModel(
    id: '1',
    name: 'nike',
    description: 'sportShoes',
    price: 23.4,
    imageUrl: 'imageUrl',
  );
  const Product testProduct = testProductModel;
  const testProductListModel = [
    ProductModel(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    ),
    ProductModel(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    )
  ];
  const testProductList = [
    Product(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    ),
    Product(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    )
  ];
  void deviceOnline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
  }

  void deviceOffline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  }

  group('getCurrentProduct', () {
    group('device is online', () {
      deviceOnline();

      test(
          'should return a product when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getSingleProduct(testProductId))
            .thenAnswer((_) async => testProductModel);

        //act
        final result = await repository.getSingleProduct(testProductId);

        //assert
        expect(result, equals(const Right(testProduct)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getSingleProduct(testProductId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getSingleProduct(testProductId);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        deviceOffline();

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.getSingleProduct(testProductId))
              .thenThrow(const SocketException('No internet connection'));
          //act
          final result = await repository.getSingleProduct(testProductId);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
  group('getAllProduct', () {
    group('device is online', () {
      deviceOnline();

      test(
          'should return a list of products when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getAllProducts())
            .thenAnswer((_) async => testProductListModel);

        //act
        final result = await repository.getAllProducts();

        final unpackedResult =
            result.fold((failure) => null, (productList) => productList);

        //assert
        expect(unpackedResult, equals(testProductList));
      });
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllProducts())
              .thenAnswer((_) async => testProductListModel);
          when(mockLocalDataSource.cacheAllProducts(testProductListModel))
              .thenAnswer((_) async => const Right(null));
          // act

          await repository.getAllProducts();
          // assert
          verify(mockRemoteDataSource.getAllProducts());
          verify(mockLocalDataSource.cacheAllProducts(testProductListModel));
        },
      );
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getSingleProduct(testProductId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getCurrentProduct(testProductId);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is offline', () {
        // This setUp applies only to the 'device is online' group
        deviceOffline();
        test('should return cached products when no network is available',
            () async {
          //arrange
          when(mockLocalDataSource.getAllProducts())
              .thenAnswer((_) async => testProductListModel);

          //act
          final result = await repository.getAllProducts();
          final unpackedResult =
              result.fold((failure) => null, (productList) => productList);

          //assert
          expect(unpackedResult, equals(testProductList));
        });
        test('should return cache failure when failing to get cached products',
            () async {
          //arrange
          when(mockLocalDataSource.getAllProducts())
              .thenThrow(CacheException());

          //act
          final result = await repository.getAllProducts();

          //assert
          expect(result, equals(Left(CacheFailure())));
        });
      });
    });
  });
  group('createProduct', () {
    group('device is online', () {
      deviceOnline();

      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.createProduct(testProductModel))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.createProduct(testProduct);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.createProduct(testProductModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.createProduct(testProduct);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        deviceOffline();

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.createProduct(testProductModel))
              .thenThrow(const SocketException('Failed to connect'));
          //act
          final result = await repository.createProduct(testProduct);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
  group('editProduct', () {
    group('device is online', () {
      deviceOnline();

      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.updateProduct(testProductModel))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.updateProduct(testProduct);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.updateProduct(testProductModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.updateProduct(testProduct);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        deviceOffline();

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.updateProduct(testProductModel))
              .thenThrow(const SocketException('Failed to connect'));
          //act
          final result = await repository.updateProduct(testProduct);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
  group('deleteProduct', () {
    group('device is online', () {
      deviceOnline();

      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.deleteProduct(testProductId))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.deleteProduct(testProductId);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.updateProduct(testProductModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.updateProduct(testProduct);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        deviceOffline();

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.updateProduct(testProductModel))
              .thenThrow(const SocketException('Failed to connect'));
          //act
          final result = await repository.updateProduct(testProduct);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
}