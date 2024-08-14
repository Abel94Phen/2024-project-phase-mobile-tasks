import '../models/product_model.dart';

abstract class ProductRemoteDataSources {
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<ProductModel> getSingleProduct(String productId);
  Future<List<ProductModel>> getAllProducts();
}