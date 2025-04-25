import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final String imagepath;
  final double height;
  final double width;

  SignInButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.height,
    required this.width,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color.fromARGB(255, 213, 211, 211),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagepath,
                height: height * 0.6, // Adjusted height
                width: width * 0.15,  // Adjusted width
                fit: BoxFit.contain,  // Ensures the image is fully visible
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
