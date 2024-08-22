import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<void> cacheAllProducts(List<ProductModel> producToCache);
}

const cachedProducts = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAllProducts(List<ProductModel> producToCache) {
    try {
      final jsonProduct = json.encode(ProductModel.toJsonList(producToCache));

      return sharedPreferences.setString(cachedProducts, jsonProduct);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    try {
      final productsString = sharedPreferences.getString(cachedProducts);
      if (productsString != null) {
        final decodedJson = json.decode(productsString);

        return Future.value(ProductModel.fromJsonList(decodedJson));
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}