import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable{
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoading extends ProductState {}

class LoadAllProductState extends ProductState {
  final List<Product> products;

  const LoadAllProductState({required this.products});

  @override
  List<Object> get props => [products];
}

class LoadSingleProductState extends ProductState {
  final Product product;

  const LoadSingleProductState({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductErrorState extends ProductState {
  final String message;

  const ProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductDeletedState extends ProductState {}

class ProductUpdatedState extends ProductState {
  final Product product;

  const ProductUpdatedState({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductCreatedState extends ProductState {
  final Product product;

  const ProductCreatedState({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductUpdatedErrorState extends ProductState {
  final String message;

  const ProductUpdatedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductCreatedErrorState extends ProductState {
  final String message;

  const ProductCreatedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}