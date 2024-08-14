import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository _productrepository;

  UpdateProduct(this._productrepository);

  Future<Either<Failure, void>> execute(Product product)  {
    return _productrepository.updateProduct(product);
  }
}