import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color? borderColor; // Change the type to Color?

  const MyTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.borderColor, // Remove the default value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? Colors.green, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? Colors.green, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
