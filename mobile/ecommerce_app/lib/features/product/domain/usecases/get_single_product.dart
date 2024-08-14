import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetSingleProduct {
  final ProductRepository _productRepository;

  GetSingleProduct(this._productRepository);

  Future<Either<Failure, Product>> execute(String productId){
    return _productRepository.getSingleProduct(productId);
  }
}