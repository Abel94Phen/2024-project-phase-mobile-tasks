import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository _productRepository;

  CreateProduct(this._productRepository);

  Future<Either<Failure, void>> execute(Product product){
    return _productRepository.createProduct(product);
  }
}