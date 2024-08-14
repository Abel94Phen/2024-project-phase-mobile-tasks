import 'dart:convert';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';
void main() {

  const testProductModel = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'This is Product 1',
    imageUrl: 'product1.jpg',
    price: 100
  );
  test(
    'Should be a subclass of product entity',
    () async {
      expect(testProductModel, isA<Product>());
    }
  );

  test(
    'Should return a valid model from json',
    () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readjson('helpers/dummy_data/dummy_product_data.json'
        )
      )[0];

      final result = ProductModel.fromJson(jsonMap);
      expect(result, equals(testProductModel));
    }
  );

  test(
    'Should return a json map containing proper data',
    () async {
      final result = testProductModel.toJson();

      final expextedJsonMap = [
        {
          'id' : '1',
          'name' : 'Product 1',
          'price' : 100.0,
          'description' : 'This is Product 1',
          'imageUrl' : 'product1.jpg'
        },

      ];

      expect(result, expextedJsonMap[0]);
    }
  );
}