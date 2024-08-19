class Urls {
  static const baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';
  static String currentProductById(String id) => '$baseUrl/$id';
}