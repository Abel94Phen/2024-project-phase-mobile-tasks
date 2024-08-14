import 'package:ecommerce_app/features/product/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> saveProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts() {
    // TODO: Implement the logic to fetch products from local storage
    throw UnimplementedError();
  }

  @override
  Future<void> saveProducts(List<ProductModel> products) {
    // TODO: Implement the logic to save products to local storage
    throw UnimplementedError();
  }
}