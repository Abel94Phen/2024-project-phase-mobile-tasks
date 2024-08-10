import 'package:flutter/material.dart';
import '../models/products.dart';
import '../widgets/rectangular_button_widget.dart';

class DetailsPage extends StatelessWidget {
  final Product product;

  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      product.category, // Display product category dynamically
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 2,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '4.0',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      product.name, // Display product name dynamically
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$${product.price}', // Display product price dynamically
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('Size', style: TextStyle(fontSize: 16)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(15, (index) {
                    int number = 30 + index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          debugPrint('Button $number pressed');
                        },
                        child: Text('$number'),
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  product
                      .description, // Display product description dynamically
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 20), // Add some spacing before the buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomRectangularButton(
                      text: 'DELETE',
                      borderColor: Colors.red,
                      textColor: Colors.red,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        debugPrint('Delete pressed');
                      },
                    ),
                    CustomRectangularButton(
                      text: 'UPDATE',
                      borderColor: const Color.fromARGB(255, 63, 81, 243),
                      textColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 63, 81, 243),
                      onPressed: () {
                        debugPrint('Update pressed');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
