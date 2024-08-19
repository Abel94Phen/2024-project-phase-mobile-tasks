import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';



void main() {
  late GetAllProductsUsecase getAllProductsUsecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProductsUsecase = GetAllProductsUsecase(mockProductRepository);
  });

  const testProductDetail = [
    Product(
        id: '1',
        name: 'Nike',
        description: 'brand new nike airforce',
        price: 23.4,
        imageUrl: 'imageUrl'),

    Product(
        id: '2',
        name: 'Adidas',
        description: 'brand new adidas easy',
        price: 23.4,
        imageUrl: 'imageUrl')
  ];

  group('Getting All Products', (){
    test(
    'should get all products from the repository',
    () async {
      //arrange
      when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => const Right(testProductDetail));
    
      //act
      final result = await getAllProductsUsecase.call(NoParams());
      
      //assert
      expect(result, const Right(testProductDetail));
  });

  test('should return a failure when failure occurs', () async {
      //arrange
      when(mockProductRepository.getAllProducts()).thenAnswer(
          (_) async => const Left(ServerFailure('test error message')));

      //act
      final result = await getAllProductsUsecase(NoParams());

      //expect
      expect(result, const Left(ServerFailure('test error message')));
    });
  });
  
}