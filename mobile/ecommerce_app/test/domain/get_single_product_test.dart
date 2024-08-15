import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetSingleProduct getSingleProduct;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    getSingleProduct = GetSingleProduct(mockProductRepository);
  });

  const testProductDetail = Product(
    id: '1',
    name: 'Product 1',
    description: 'This is Product 1',
    imageUrl: 'product1.jpg',
    price: 100
  );

  const productId = '1';

  test(
    'Should get current product detail from the repository',
    () async {
      //arrange
      when(
        mockProductRepository.getSingleProduct(productId)
      ).thenAnswer((_) async => const Right(testProductDetail));

      //act
      final result = await getSingleProduct.execute(productId);

      //assert
      expect(result, const Right(testProductDetail));

    }
  );
}