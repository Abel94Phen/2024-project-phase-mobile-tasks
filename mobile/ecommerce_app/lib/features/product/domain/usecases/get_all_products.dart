import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository _productRepository;

  GetAllProducts(this._productRepository);

  Future<Either<Failure, List<Product>>> execute() {
    return _productRepository.getAllProducts();
  }
}