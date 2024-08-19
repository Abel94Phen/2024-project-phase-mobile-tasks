import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/enitities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late CreateProductUsecase createProductUsecase;

  setUp((){
    mockProductRepository = MockProductRepository();
    createProductUsecase = CreateProductUsecase(mockProductRepository);
  });

  const testProductDetail = Product(
    id: '1',
    name: 'Nike',
    description: 'brand new nike aiforce',
    price: 23.4,
    imageUrl: 'imageUrl'
  );

  test(
    'should create a product',
    () async {
      //arrange
      when(mockProductRepository.createProduct(testProductDetail)
      ).thenAnswer((_) async => const Right(testProductDetail));
    
      //act
      final result = await createProductUsecase.call(const CreateParams(product: testProductDetail));
      
      //assert
      expect(result, const Right(testProductDetail));
  });

}