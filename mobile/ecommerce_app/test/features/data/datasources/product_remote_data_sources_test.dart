import 'dart:convert';
import 'dart:io';


import 'package:ecommerce_app/core/constants/urls.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_sources.dart';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helpers.mocks.dart';


void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl = ProductRemoteDataSourceImpl(
      client: mockHttpClient
    );
  });

  const productId = '6672776eb905525c145fe0bb';
  const jsonCurrent = 'helpers/dummy_data/mock_product_api.json';

  const testProductModel = ProductModel(
      id: '6672776eb905525c145fe0bb',
      name: 'Anime website',
      description: 'Explore anime characters.',
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777711/images/clmxnecvavxfvrz9by4w.jpg',
      price: 123);

  group(
    'Get Single Product',
    () {
      test('Should return product model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.currentProductById(productId)))).
        thenAnswer((_) async => http.Response(readJson(jsonCurrent), 200));

        // act
        final result = await productRemoteDataSourceImpl.getSingleProduct(productId);

        // assert
        expect(result, isA<ProductModel>());
      });

      test('Should throw server exception if status code is other than 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.currentProductById(productId)))).
        thenAnswer((_) async => http.Response(readJson(jsonCurrent), 400));

        //act // assert
        expect(() => productRemoteDataSourceImpl.getSingleProduct(productId),
          throwsA(isA<ServerException>()));
      });

      test('Should throw a scoket excption', (){
        // arrange
        final jsonBody = jsonEncode( {
          'name': testProductModel.name,
          'description': testProductModel.description,
          'price': testProductModel.price,
        });
        when(mockHttpClient.put(Uri.parse(Urls.currentProductById(productId)),
          body: jsonBody,headers: {'Content-Type': 'application/json'}))
          .thenThrow(const SocketException(
            'No Internet connection or server unreachable'));
        
        //act
        final call = productRemoteDataSourceImpl.updateProduct;

        //assert
        expect(() => call(testProductModel), throwsA(isA<SocketException>()));
      });
    }
  );


}