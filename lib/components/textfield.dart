import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final double height;
  final bool ObscureText;

  const Textfield({
    required this.ObscureText,
    required this.controller,
    required this.height,
    required this.text,
    super.key,
  });

  @override
  _TextfieldState createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.ObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: widget.height),
        SizedBox(
          width: 500,
          height: 50,
          child: TextField(
            obscureText: isObscured,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.text,
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 103, 101, 101),
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 39, 37, 37),
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              suffixIcon: widget.ObscureText
                  ? IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
