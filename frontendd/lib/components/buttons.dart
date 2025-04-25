import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final Text text;
  final Function()? onTap;
  final Color color; // Added color attribute
  final Color color1;
  final double height;
  final double width;

  Buttons(
      {super.key,
      required this.onTap,
      required this.text,
      required this.color,
      required this.color1,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: color, // Use the provided color
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: color1,
                width: 2,
              )),
          height: height,
          width: width,
          child: Center(child: text),
        ),
      ),
    );
  }
}

