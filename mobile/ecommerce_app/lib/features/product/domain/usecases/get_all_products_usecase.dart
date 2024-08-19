import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../enitities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductsUsecase implements Usecase<List<Product>, NoParams>{
  final ProductRepository productRepository;

  GetAllProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return productRepository.getAllProducts();
  }
}

class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}