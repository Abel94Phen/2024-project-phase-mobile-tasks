import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late UpdateProduct updateProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProduct = UpdateProduct(mockProductRepository);
  });

  const testProductDetail = Product(
    id: '1',
    name: 'Nike',
    description: 'brand new Nike Airforce',
    price: 23.4,
    imageUrl: 'imageUrl',
  );

  const updatedTestProductDetail = Product(
    id: '1',
    name: 'Puma',
    description: 'brand new Nike Airforce',
    price: 30.8,
    imageUrl: 'imageUrl',
  );

  test(
    'should edit the product in the repository',
    () async {
      // Arrange
      when(mockProductRepository.updateProduct(any)
      ).thenAnswer((_) async => const Right(updatedTestProductDetail));

      // Act
      final result = await updateProduct.execute(testProductDetail);

      // Assert
      expect(result, const Right(updatedTestProductDetail));
  });
}
