import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3B5998)),
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF3B5998),
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
