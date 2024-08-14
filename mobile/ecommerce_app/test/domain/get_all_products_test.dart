import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';


void main() {
  late GetAllProducts getAllProducts;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProducts = GetAllProducts(mockProductRepository);
  });
  const testProductdetail = [
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

  test('should get all products from the repository', () async {
    //arrange
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => const Right(testProductdetail));
    //act
    final result = getAllProducts;
    //assert
    expect(result, const Right(testProductdetail));
    verify(mockProductRepository.getAllProducts());
  });
}