import 'package:flutter/material.dart';
import 'package:product6/screens/add_update_screen.dart';
import 'package:product6/screens/search_screen.dart';
import 'package:product6/widgets/date_greeting_widget.dart';
import 'package:product6/widgets/product_card_widget.dart';
import 'package:product6/models/products_list.dart';
import 'package:product6/models/products.dart';
import '../widgets/grey_box_widget.dart';
import 'details_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(children: <Widget>[
              const GreyBox(),
              const SizedBox(width: 20.0),
              const DateGreeting(date: "July 24, 2023", name: "Yohannes"),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_none_outlined,
                      semanticLabel: 'notification'),
                  onPressed: () {
                    debugPrint("Notification Pressed");
                  },
                ),
              )
            ]),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    "Available Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, semanticLabel: 'search'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: productData.length,
                itemBuilder: (context, index) {
                  String key = productData.keys.elementAt(index);
                  Product product = productData[key]!;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(product: product),
                        ),
                      );
                    },
                    child: ProductCard(
                      imageUrl: product.image,
                      productName: product.name,
                      price: product.price,
                      rating: 4.0,
                      category: product.category,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUpdatepage(),
            ),
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 63, 81, 243),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
