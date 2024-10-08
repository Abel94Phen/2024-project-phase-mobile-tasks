import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable{
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProductEvent extends ProductEvent {}

class GetSingleProductEvent extends ProductEvent {
  final String productId;

  const GetSingleProductEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;

  const UpdateProductEvent({required this.product}); 

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String productId;

  const DeleteProductEvent({required this.productId});


  @override
  List<Object> get props => [productId];
}


class CreateProductEvent extends ProductEvent {
  final Product product;

  const CreateProductEvent({required this.product});


  @override
  List<Object> get props => [product];
}