import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository _productrepository;

  DeleteProduct(this._productrepository);

  Future<Either<Failure, void>> execute(String productId)  {
    return _productrepository.deleteProduct(productId);
  }
}