import 'package:flutter/material.dart';

class DateGreeting extends StatelessWidget {
  final String date;
  final String name;

  const DateGreeting({
    super.key,
    required this.date,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(75, 75, 75, 0.6),
            ),
          ),
          Text(
            "Hello, $name",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(0, 0, 0, 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
