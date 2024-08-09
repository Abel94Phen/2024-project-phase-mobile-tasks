import 'package:flutter/material.dart';

class GreyBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderWidth;

  // Default constructor with default values
  const GreyBox({
    super.key,
    this.width = 40.0,
    this.height = 40.0,
    this.color = Colors.grey,
    this.borderWidth = 1.0,
  });

  // Constructor for a custom color
  const GreyBox.withColor({
    super.key,
    required Color boxColor,
  })  : width = 40.0,
        height = 40.0,
        color = boxColor,
        borderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.black,
          width: borderWidth,
        ),
      ),
    );
  }
}
