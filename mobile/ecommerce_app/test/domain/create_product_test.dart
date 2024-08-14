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
  const testProductdetail = Product(
      id: '1',
      name: 'Nike',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');

  test('should all the product to the repository', () async {
    //arrange

    when(mockProductRepository.createProduct(any))
        .thenAnswer((_) async => const Right(null));
    //act
    final result = createProduct.execute(testProductdetail);
    //assert
    expect(result, const Right(null));
    verify(mockProductRepository.createProduct(testProductdetail));
  });
}