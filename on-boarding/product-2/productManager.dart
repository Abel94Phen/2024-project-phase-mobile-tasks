import 'dart:io';

import 'product.dart';

class ProductManager {
  List<Product> _products;

  // Constructor
  ProductManager(this._products);

  // Getters for the properties
  List<Product> get products => this._products;

  // Setters for the properties
  set products(List<Product> newProducts) {
    this._products = newProducts;
  }

  // Object methods
  void addProduct(Product newProduct) {
    for (Product product in this._products) {
      if (product.name == newProduct.name) {
        print("Product Already Exists");
        return;
      }
    }
    this._products.add(newProduct);
    print("Product Successfully Added.");
  }

  void viewProducts() {
    if (this._products.isEmpty) {
      print("No products exist here");
    } else {
      for (Product product in this._products) {
        print(product);
      }
    }
  }

  void viewProduct(String productName) {
    for (Product product in this._products) {
      if (product.name == productName) {
        print(product);
        return;
      }
    }
    print("Product Not Found");
  }

  void editProduct(String productName) {
    for (int i = 0; i < _products.length; i++) {
      if (_products[i].name == productName) {
        print("Product Found");
        print("Enter the updated info");
        print("=========================");
        print("Name: ");
        _products[i].name = stdin.readLineSync()!;
        print("Description: ");
        _products[i].description = stdin.readLineSync()!;
        print("Price: ");
        _products[i].price = double.parse(stdin.readLineSync()!);
        print("Product Updated Successfully.");
        return;
      }
    }
    print("No Such Product");
  }

  void deleteProduct(String productName) {
    for (int i = 0; i < _products.length; i++) {
      if (_products[i].name == productName) {
        print("Product Found");
        _products.removeAt(i);
        print("Product Deleted successfully!");
        return;
      }
    }
    print("No Such Product exists");
  }
}
