import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late CreateProduct createProduct;
  late MockProductRepository mockProductRepository;
  
  setUp(() {
    mockProductRepository = MockProductRepository();
    createProduct = CreateProduct(mockProductRepository);
  });
  
  const testProductDetail = Product(
      id: '1',
      name: 'Nike',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');

  test(
    'should create a product',
    () async {
      //arrange
      when(mockProductRepository.createProduct(testProductDetail)
      ).thenAnswer((_) async => const Right(testProductDetail));
    
      //act
      final result = await createProduct.execute(testProductDetail);
      
      //assert
      expect(result, const Right(testProductDetail));
  });
}