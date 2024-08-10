import 'package:flutter/material.dart';
import 'package:product6/screens/add_update_screen.dart';
import 'package:product6/screens/search_screen.dart';
import 'models/products.dart';
import 'screens/details_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/homepage':
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
          case '/detailspage':
            final Product product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) => DetailsPage(product: product),
            );
          case '/addupdatepage':
            return MaterialPageRoute(
              builder: (context) => const AddUpdatepage(),
            );
          case '/searchpage':
            return MaterialPageRoute(
              builder: (context) => const SearchPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}
