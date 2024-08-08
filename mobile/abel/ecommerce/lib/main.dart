import 'package:flutter/material.dart';
// import 'homepage.dart';
// import 'detailspage.dart';
// import 'addUpdatePage.dart';
import 'searchpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: const Searchpage(),
    );
  }
}
