import 'package:flutter/material.dart';

import '../widgets/rectangular_button_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Add SingleChildScrollView here
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
                      'shoes.jpg',
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Men's Shoe",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
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
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Derby Leather',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$120',
                      style: TextStyle(
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
                            borderRadius: BorderRadius
                                .zero, // Makes the button rectangular
                          ),
                        ),
                        onPressed: () {
                          print('Button $number pressed');
                        },
                        child: Text('$number'),
                      ),
                    );
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                  style: TextStyle(fontSize: 12),
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
