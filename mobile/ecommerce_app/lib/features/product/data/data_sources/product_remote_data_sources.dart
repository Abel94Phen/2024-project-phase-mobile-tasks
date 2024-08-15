import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getSingleProduct(String productId);
  Future<ProductModel> createProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  
  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    var uri = Uri.parse(Urls.baseUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();

    if (product.imageUrl.isNotEmpty) {
      var imageFile = File(product.imageUrl);
      debugPrint(
        'created image: ${imageFile.existsSync()}, ${product.imageUrl}'
      );
      if (imageFile.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            product.imageUrl,
            contentType: MediaType('image', 'jpg',)
          )
        );
      } else {
        throw ImageException();
      }
    }

    try {
      http.StreamedResponse streamedResponse = await request.send();
      if (streamedResponse.statusCode == 201) {
        final responseString = await streamedResponse.stream.bytesToString();
        final jsonResponse = json.decode(responseString);
        return ProductModel.fromJson(jsonResponse['data']);
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException(ErrorMessages.socketError);
    } catch(e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      final response = await client.delete(Uri.parse(Urls.currentProductById(productId)));
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException(ErrorMessages.socketError);
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final productId = product.id;
    final jsonBody = {
      'name': product.name,
      'description': product.description,
      'price': product.price,
    };

    try {
      final response = await client.put(
        Uri.parse('${Urls.baseUrl}/$productId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonBody),
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(json.decode(response.body)['data']);
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException(ErrorMessages.socketError);
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client.get(Uri.parse(Urls.baseUrl));
      if (response.statusCode == 200) {
        return ProductModel.fromJsonList(jsonDecode(response.body)['data']);
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException(ErrorMessages.socketError);
    }
  }

  @override
  Future<ProductModel> getSingleProduct(String productId) async {
    try {
      final response = await client.get(Uri.parse(Urls.currentProductById(productId)));
      if (response.statusCode == 200) {
        return ProductModel.fromJson(json.decode(response.body)['data']);
      } else {
        throw ServerException();
      } 
    } on SocketException {
      throw const SocketException(ErrorMessages.socketError);
    }
  }
}