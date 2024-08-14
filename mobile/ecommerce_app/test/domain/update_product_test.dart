import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
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
  const testProductdetail = Product(
      id: '1',
      name: 'Nike',
      description: 'brand new nike aiforce',
      price: 23.4,
      imageUrl: 'imageUrl');
  const updatedTestProductDetail = Product(
      id: '1',
      name: 'puma',
      description: 'brand new nike aiforce',
      price: 30.8,
      imageUrl: 'imageUrl');

  test('should edit the product from the repository', () async {
    //arrange

    when(mockProductRepository.updateProduct(any))
        .thenAnswer((_) async => const Right(updatedTestProductDetail));
    //act
    final result = await UpdateProduct(testProductdetail as ProductRepository);
    //assert
    expect(result, const Right(updatedTestProductDetail));
    verify(mockProductRepository.updateProduct(testProductdetail));
  });
}