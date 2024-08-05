import 'dart:io';
import 'product.dart';
import 'productManager.dart';

var productManagers = {
  'PM1': ProductManager([
    Product('Laptop', 'A high-performance laptop with 16GB RAM and 512GB SSD.',
        1200.00),
    Product(
        'Smartphone', 'A latest-gen smartphone with 128GB storage.', 799.99),
    Product('Headphones', 'Noise-cancelling headphones.', 199.99),
    Product('Tablet', 'A 10-inch tablet with a vibrant display.', 299.99),
    Product('Smartwatch', 'A smartwatch with fitness tracking.', 149.99),
  ]),
  'PM2': ProductManager([
    Product(
        'Gaming Console', 'Next-gen gaming console with 1TB storage.', 499.99),
    Product('4K TV', 'A 55-inch 4K Ultra HD TV.', 649.99),
    Product('Bluetooth Speaker',
        'Portable Bluetooth speaker with powerful sound.', 99.99),
    Product('Wireless Mouse', 'Ergonomic wireless mouse with fast scrolling.',
        49.99),
    Product('Keyboard', 'Mechanical keyboard with RGB backlighting.', 89.99),
    Product(
        'External Hard Drive', '2TB external hard drive with USB 3.0.', 89.99),
    Product('Printer', 'Wireless all-in-one printer with scanning and copying.',
        129.99),
    Product('Camera', 'Digital camera with 20MP resolution and optical zoom.',
        399.99),
    Product('Drone', 'Quadcopter drone with 4K camera and GPS.', 599.99),
  ]),
  'PM3': ProductManager([
    Product('VR Headset', 'Virtual reality headset with immersive experience.',
        299.99),
    Product('Fitness Tracker', 'Fitness tracker with heart rate monitoring.',
        59.99),
    Product('Smart Thermostat', 'Wi-Fi smart thermostat with remote control.',
        199.99),
    Product('Robot Vacuum', 'Automatic robot vacuum cleaner with scheduling.',
        249.99),
    Product('Electric Toothbrush',
        'Rechargeable electric toothbrush with multiple modes.', 79.99),
    Product('Air Purifier', 'HEPA air purifier for clean indoor air.', 149.99),
  ]),
};

int showMenu() {
  print("=============================================");
  print("======|ECOMMERCE COMMAND LINE APP|===========");
  print("=============================================");
  print("=========Please Choose an Option=============");
  print("1. View All Products");
  print("2. View Single Product");
  print("3. Add Product");
  print("4. Edit Product");
  print("5. Delete Product");
  print("6. Exit");
  int choice = int.parse(stdin.readLineSync()!);
  return choice;
}

void main() {
  while (true) {
    int choice = showMenu();
    switch (choice) {
      case 1:
        {
          print("Enter Product Manager (PM1, PM2, PM3): ");
          String manager = stdin.readLineSync()!;
          productManagers[manager]?.viewProducts();
          break;
        }
      case 2:
        {
          print("Enter Product Manager (PM1, PM2, PM3): ");
          String manager = stdin.readLineSync()!;
          print("Enter Product Name: ");
          String name = stdin.readLineSync()!;
          productManagers[manager]?.viewProduct(name);
          break;
        }
      case 3:
        {
          print("Enter Product Manager (PM1, PM2, PM3): ");
          String manager = stdin.readLineSync()!;
          print("Enter Product Name: ");
          String name = stdin.readLineSync()!;
          print("Enter Product Description: ");
          String description = stdin.readLineSync()!;
          print("Enter Product Price: ");
          double price = double.parse(stdin.readLineSync()!);
          productManagers[manager]
              ?.addProduct(Product(name, description, price));
          break;
        }
      case 4:
        {
          print("Enter Product Manager (PM1, PM2, PM3): ");
          String manager = stdin.readLineSync()!;
          print("Enter Product Name to Edit: ");
          String name = stdin.readLineSync()!;
          productManagers[manager]?.editProduct(name);
          break;
        }
      case 5:
        {
          print("Enter Product Manager (PM1, PM2, PM3): ");
          String manager = stdin.readLineSync()!;
          print("Enter Product Name to Delete: ");
          String name = stdin.readLineSync()!;
          productManagers[manager]?.deleteProduct(name);
          break;
        }
      case 6:
        {
          print("Exiting...");
          exit(0);
        }
      default:
        {
          print("Invalid choice, please try again.");
        }
    }
  }
}
