import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_single_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUsecase _getAllProductsUsecase;
  final GetSingleProductUsecase _getSingleProductUsecase;
  final CreateProductUsecase _createProductUsecase;
  final DeleteProductUsecase _deleteProductUsecase;
  final UpdateProductUsecase _updateProductUsecase;

  ProductBloc(
      this._getAllProductsUsecase,
      this._getSingleProductUsecase,
      this._createProductUsecase,
      this._updateProductUsecase,
      this._deleteProductUsecase)
      : super(ProductInitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await _getSingleProductUsecase(Params(productId: event.productId));
      result.fold(
          (failure) => emit(
                ProductErrorState(message: failure.message),
              ),
          (product) => emit(LoadSingleProductState(product: product)));
    });

    on<LoadAllProductEvent>((event, emit) async {
      debugPrint('LoadAllProductEvent has been dispatched');
      emit(ProductLoading());
      final result = await _getAllProductsUsecase(NoParams());
      result.fold(
          (failure) => emit(
                ProductErrorState(message: failure.message),
              ),
          (products) => emit(LoadAllProductState(products: products)));
    });

    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result =
          await _createProductUsecase(CreateParams(product: event.product));
      result.fold(
          (failure) => emit(
                ProductCreatedErrorState(message: failure.message),
              ),
          (product) => emit(ProductCreatedState(product: product)));
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result =
          await _updateProductUsecase(UpdateParams(product: event.product));
      result.fold(
          (failure) => emit(
                ProductUpdatedErrorState(message: failure.message),
              ),
          (product) => emit(ProductUpdatedState(product: product)));
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await _deleteProductUsecase(DeleteParams(productId: event.productId));
      result.fold(
          (failure) => emit(
                ProductErrorState(message: failure.message),
              ),
          (product) => emit(ProductDeletedState()));
    });
  }
}