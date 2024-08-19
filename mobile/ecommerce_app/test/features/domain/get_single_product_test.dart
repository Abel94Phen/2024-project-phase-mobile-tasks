import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helpers.mocks.dart';

void main(){
  late GetSingleProductUsecase getSingleProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    getSingleProductUsecase = GetSingleProductUsecase(mockProductRepository);
  });

  const testProductDetail = Product(
    id: '1',
    name: 'Product 1',
    description: 'This is Product 1',
    imageUrl: 'product1.jpg',
    price: 100
  );

  const productId = '1';

  group('Getting A Single Product', (){
    test(
    'Should get current product detail from the repository',
    () async {
      //arrange
      when(mockProductRepository.getSingleProduct(productId)
      ).thenAnswer((_) async => const Right(testProductDetail));

      //act
      final result = await getSingleProductUsecase.call(const Params(productId: productId));  

      //assert
      expect(result, const Right(testProductDetail));
    }
  );

  test('should return a failure when failure occurs', () async {
      //arrange
      when(mockProductRepository.getSingleProduct(productId)).thenAnswer(
          (_) async => const Left(ServerFailure('test error message')));

      //act
      final result = await getSingleProductUsecase(const Params(productId: productId));

      //expect
      expect(result, const Left(ServerFailure('test error message')));
    });
  });
  
}