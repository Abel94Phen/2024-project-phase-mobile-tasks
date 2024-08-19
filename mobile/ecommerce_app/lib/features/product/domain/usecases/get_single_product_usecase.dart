import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../enitities/product.dart';
import '../repositories/product_repository.dart';

class GetSingleProductUsecase implements Usecase<Product, Params> {
  final ProductRepository productRepository;

  GetSingleProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product>> call(Params params) async {
    return await productRepository.getSingleProduct(params.productId);
  }
}

class Params extends Equatable {
  final String productId;

  const Params({required this.productId});

  @override
  List<Object?> get props => [productId];
}