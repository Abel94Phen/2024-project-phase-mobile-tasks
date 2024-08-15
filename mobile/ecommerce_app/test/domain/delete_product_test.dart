import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';


void main() {
  late DeleteProduct deleteProduct;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProduct = DeleteProduct(mockProductRepository);
  });

  const testProductId = '1';
  test(
    'should delete the product from the repository',
    () async {
  
      //arrange
      when(mockProductRepository.deleteProduct(testProductId))
        .thenAnswer((_) async => const Right(null));
  
      //act
      final result = await deleteProduct.execute(testProductId);
    
      //assert
      expect(result, const Right(null));
    
  });
}