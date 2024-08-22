import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase implements Usecase<void, DeleteParams>{
  final ProductRepository productRepository;

  DeleteProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, void>> call(DeleteParams params) {
    return productRepository.deleteProduct(params.productId);
  }
}

class DeleteParams extends Equatable {
  final String productId;

  const DeleteParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}