// widgets/bottom_navigation_bar.dart

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Color(0xFF3B5998),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: 'Itenerary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.price_check),
          label: 'Cost',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.question_answer),
        //   label: 'FAQ',
        // ),
      ],
    );
  }
}
