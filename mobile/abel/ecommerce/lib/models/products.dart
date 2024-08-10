class Product {
  const Product({
    required this.image,
    required this.category,
    required this.description,
    required this.name,
    required this.price,
  });

  final String category;
  final String image;
  final String description;
  final String name;
  final double price;
}
