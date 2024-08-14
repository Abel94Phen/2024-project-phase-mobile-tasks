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
}