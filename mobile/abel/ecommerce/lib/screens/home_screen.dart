import 'package:flutter/material.dart';
import 'package:product6/widgets/date_greeting_widget.dart';
import 'package:product6/widgets/product_card_widget.dart';

import '../widgets/grey_box_widget.dart';

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
                      debugPrint("Search Pressed");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const ProductCard(
                    imageUrl: 'shoes.jpg',
                    productName: 'Derby Leather Shoes',
                    price: 120,
                    rating: 4.0,
                    category: "Men's Shoe",
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB Pressed");
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 63, 81, 243),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
