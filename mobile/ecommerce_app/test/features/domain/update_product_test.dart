import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late UpdateProductUsecase updateProductUsecase;

  setUp((){
    mockProductRepository = MockProductRepository();
    updateProductUsecase = UpdateProductUsecase(mockProductRepository);
  });

  const testProductDetail = Product(
    id: '1',
    name: 'Nike',
    description: 'brand new nike aiforce',
    price: 23.4,
    imageUrl: 'imageUrl'
  );

  group('Updating a Product', (){
    test(
    'should update a product',
    () async {
      //arrange
      when(mockProductRepository.updateProduct(testProductDetail)
      ).thenAnswer((_) async => const Right(testProductDetail));
    
      //act
      final result = await updateProductUsecase.call(const UpdateParams(product: testProductDetail));
      
      //assert
      expect(result, const Right(testProductDetail));
  });

  test('should return a failure when failure occurs', () async {
    //arrange
    when(mockProductRepository.updateProduct(testProductDetail))
        .thenAnswer((_) async => const Left(ServerFailure('test error message')));

    //act
    final result = await updateProductUsecase(const UpdateParams(product: testProductDetail));

    //expect
    expect(result, const Left(ServerFailure('test error message')));
  });
  });

}