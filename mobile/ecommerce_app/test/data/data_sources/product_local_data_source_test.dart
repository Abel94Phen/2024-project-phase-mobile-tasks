import 'dart:convert';

import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('getAllProducts', () {
    final jsonList = json.decode(
        readjson('test/helpers/dummy_data/product_cached_response.json'));
    final testProductModelList = ProductModel.fromJsonList(jsonList);
    
    test(
        'should return cached products from shared reference when there is one in the cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(json.encode(jsonList));

      //act
      final result = await dataSource.getAllProducts();

      //assert
      verify(mockSharedPreferences.getString(cachedProducts));
      expect(result, equals(testProductModelList));
    });
    test('should throw cache exception when there is not a cached value',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //act
      final call = dataSource.getAllProducts;

      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('cacheAllProducts', () {
    
    const testProductModelList = [
      ProductModel(
          id: '1',
          name: 'Test shoes',
          description: 'A brand nike for the summer',
          imageUrl: 'nike.jpg',
          price: 15.33)
    ];

    test('should call SharedPreference to cache the data', () {
      //arrange
      final expectedJson =
          json.encode(ProductModel.toJsonList(testProductModelList));
      when(mockSharedPreferences.setString(any, expectedJson))
          .thenAnswer((_) async => true);

      //act
      dataSource.cacheAllProducts(testProductModelList);

      //assert

      verify(mockSharedPreferences.setString(cachedProducts, expectedJson));
    });
  });
}