import 'package:flutter/material.dart';

class CustomRectangularButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomRectangularButton({
    super.key,
    required this.text,
    required this.borderColor,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Rectangular shape
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 10), // Set a default smaller font size
      ),
    );
  }
}
