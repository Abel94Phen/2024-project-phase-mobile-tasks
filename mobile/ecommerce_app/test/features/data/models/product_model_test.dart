import 'dart:convert';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/json_reader.dart';

void main() {

  const testProductModel = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Product 1 description',
    imageUrl: 'product1.jpg',
    price: 100
  );
  
  test(
    'Should be a subclass of product entity',
    () async {
      // assert
      expect(testProductModel, isA<Product>());
    }
  );

  test(
    'Should return a valid model from json',
    () async {

      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_product_response.json'
        )
      )[0];

      // act
      final result = ProductModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testProductModel));
    }
  );

  test(
    'Should return a json map containing proper data',
    () async {

      // arrange
      final Map<String, dynamic> jsonMap = json
        .decode(readJson('helpers/dummy_data/dummy_product_response.json'))[0];

      // act
      final result = testProductModel.toJson();

      // assert
      expect(result, jsonMap);
    }
  );
}