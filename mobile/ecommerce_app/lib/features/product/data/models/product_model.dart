import '../../domain/entities/product.dart';

class ProductModel extends Product{
  // Defining the constructor for the ProductModel
  // Calling the super parameter to populate the values
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl
    });
  
  // Defines a named constructor to create a ProductModel object from a JSON map.
  // Utilizes a `factory` constructor to return an existing instance if available,
  // or creates and returns a new ProductModel instance if it doesn't already exist.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
  
  // Returns a Product with the values of the productModel
  Product toProduct() => Product(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl
    );
  
  // Returns a JSON representation of the Product
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }


  // STATIC METHODS

  // Converts a list of JSON represntations of a Product in to
  // a list of ProductModel Objects
  static List<ProductModel> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  // Converts a list of ProductModel Objects into
  // a List of JSON Representations
  static List<Map<String, dynamic>> toJsonList(List<ProductModel> products) {
    return products.map((product) => product.toJson()).toList();
  }

  // Converts a list of ProductModels in to a
  // List of Products
  static List<Product> toEntityList(List<ProductModel> models) {
    return models.map((model) => model.toProduct()).toList();
  }

  // Casts a Product to a ProductModel
  // Helps to avoid casting errors
    static ProductModel toModel(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
  }

}