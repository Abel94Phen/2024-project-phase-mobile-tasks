import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/constants/error_messages.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetSingleProductUsecase mockGetSingleProductUsecase;
  late MockGetAllProductsUsecase mockGetAllProductsUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late ProductBloc productBloc;

  setUp(() {
    mockGetSingleProductUsecase = MockGetSingleProductUsecase();
    mockGetAllProductsUsecase = MockGetAllProductsUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    productBloc = ProductBloc(
        mockGetAllProductsUsecase,
        mockGetSingleProductUsecase,
        mockCreateProductUsecase,
        mockUpdateProductUsecase,
        mockDeleteProductUsecase);
  });

  const testProductEntitiy = Product(
      id: '1',
      name: 'Product 1',
      description: 'Product 1 description',
      imageUrl: 'product1.jpg',
      price: 100);

  const testId = '1';

  test('initial state should be InitialState', () {
    expect(productBloc.state, ProductInitialState());
  });

  group('GetSingleProduct Event', () {
    blocTest<ProductBloc, ProductState>(
        'emits [LoadingState, LoadSingleProductState] when GetSingleProductEvent is added.',
        build: () {
          return productBloc;
        },
        // ignore: void_checks
        setUp: () {
          when(mockGetSingleProductUsecase(const Params(productId: testId)))
              .thenAnswer((_) async => const Right(testProductEntitiy));
          return productBloc;
        },
        act: (bloc) => bloc.add(const GetSingleProductEvent(productId: testId)),
        expect: () => [
              ProductLoading(),
              const LoadSingleProductState(product: testProductEntitiy)
            ]);

    blocTest<ProductBloc, ProductState>(
        'emits [LoadingState, ErrorState] when GetSingleProductEvent is unsuccessful.',
        build: () {
          return productBloc;
        },
        // ignore: void_checks
        setUp: () {
          when(mockGetSingleProductUsecase(const Params(productId: testId)))
              .thenAnswer((_) async =>
                  const Left(ServerFailure(ErrorMessages.serverError)));
          return productBloc;
        },
        act: (bloc) => bloc.add(const GetSingleProductEvent(productId: testId)),
        expect: () => [
              ProductLoading(),
              const ProductErrorState(message: ErrorMessages.serverError)
            ]);
  });

  group('LoadAllProduct Event', () {
    blocTest(
        'emits [LoadingState, LoadAllProductState] when LoadAllProduct Event is added',
        build: () {
          when(mockGetAllProductsUsecase(NoParams()))
              .thenAnswer((_) async => const Right([testProductEntitiy]));
          return productBloc;
        },
        act: (bloc) => bloc.add(LoadAllProductEvent()),
        expect: () => [
              ProductLoading(),
              const LoadAllProductState(products: [testProductEntitiy])
            ]);
    blocTest(
        'emits [LoadingState, ErrorState] when LoadAllProductEvent is unsuccessful.',
        build: () {
          when(mockGetAllProductsUsecase(NoParams())).thenAnswer((_) async =>
              const Left(ServerFailure(ErrorMessages.serverError)));
          return productBloc;
        },
        act: (bloc) => bloc.add(LoadAllProductEvent()),
        expect: () => [
              ProductLoading(),
              const ProductErrorState(message: ErrorMessages.serverError)
            ]);
    blocTest(
        'emits [LoadingState, ErrorState] when LoadAllProductEvent is unsuccessful.',
        build: () {
          when(mockGetAllProductsUsecase(NoParams())).thenAnswer(
              (_) async => const Left(CacheFailure(ErrorMessages.cacheError)));
          return productBloc;
        },
        act: (bloc) => bloc.add(LoadAllProductEvent()),
        expect: () => [
              ProductLoading(),
              const ProductErrorState(message: ErrorMessages.cacheError)
            ]);
  });

  group('CreateProductEvent', () {
    blocTest(
        'emits [LoadingState, LoadSingleProductState] when CreateProductEvent is added',
        build: () {
          when(mockCreateProductUsecase(
                  const CreateParams(product: testProductEntitiy)))
              .thenAnswer((_) async => const Right(testProductEntitiy));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const CreateProductEvent(product: testProductEntitiy)),
        expect: () => [
              ProductLoading(),
              const ProductCreatedState(product: testProductEntitiy)
            ]);

    blocTest(
        'emits [LoadingState, ErrorState] when CreateProductEvent is unsuccessful',
        build: () {
          when(mockCreateProductUsecase(
                  const CreateParams(product: testProductEntitiy)))
              .thenAnswer((_) async =>
                  const Left(ServerFailure(ErrorMessages.serverError)));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const CreateProductEvent(product: testProductEntitiy)),
        expect: () => [
              ProductLoading(),
              const ProductCreatedErrorState(message: ErrorMessages.serverError)
            ]);
  });

  group('UpdateProductEvent', () {
    blocTest(
        'emits [LoadingState, LoadSingleProductState] when UpdateProductEvent is added',
        build: () {
          when(mockUpdateProductUsecase(
                  const UpdateParams(product: testProductEntitiy)))
              .thenAnswer((_) async => const Right(testProductEntitiy));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const UpdateProductEvent(product: testProductEntitiy)),
        expect: () => [
              ProductLoading(),
              const ProductUpdatedState(product: testProductEntitiy)
            ]);

    blocTest(
        'emits [LoadingState, ErrorState] when UpdateProductEvent is unsuccessful',
        build: () {
          when(mockUpdateProductUsecase(
                  const UpdateParams(product: testProductEntitiy)))
              .thenAnswer((_) async =>
                  const Left(ServerFailure(ErrorMessages.serverError)));
          return productBloc;
        },
        act: (bloc) =>
            bloc.add(const UpdateProductEvent(product: testProductEntitiy)),
        expect: () => [
              ProductLoading(),
              const ProductUpdatedErrorState(message: ErrorMessages.serverError)
            ]);
  });

  group('DeleteProductEvent', () {
    blocTest(
        'emits [LoadingState, ProductDeletedState] when DeleteProductEvent is added',
        build: () {
          when(mockDeleteProductUsecase(const DeleteParams(productId: testId)))
              .thenAnswer((_) async => const Right(null));
          return productBloc;
        },
        act: (bloc) => bloc.add(const DeleteProductEvent(productId: testId)),
        expect: () => [ProductLoading(), ProductDeletedState()]);

    blocTest(
        'emits [LoadingState, ErrorState] when DeleteProductEvent is unsuccessful',
        build: () {
          when(mockDeleteProductUsecase(const DeleteParams(productId: testId))).thenAnswer(
              (_) async =>
                  const Left(ServerFailure(ErrorMessages.serverError)));
          return productBloc;
        },
        act: (bloc) => bloc.add(const DeleteProductEvent(productId: testId)),
        expect: () => [
              ProductLoading(),
              const ProductErrorState(message: ErrorMessages.serverError)
            ]);
  });
}

