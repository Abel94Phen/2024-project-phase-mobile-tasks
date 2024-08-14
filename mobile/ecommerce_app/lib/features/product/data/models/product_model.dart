import '../../domain/entities/product.dart';

class ProductModel extends Product{
  const ProductModel(
    {
      required super.id,
      required super.name,
      required super.description,
      required super.imageUrl,
      required super.price
    }
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id : json['id'],
    name : json['name'],
    description : json['description'],
    imageUrl: json['imageUrl'],
    price : json['price']
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'price' : price,
    'description' : description,
    'imageUrl' : imageUrl
  };
}