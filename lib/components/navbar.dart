import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const Navbar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 55,
      index: currentIndex,
      animationCurve: Curves.easeInOut,
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.pink.shade100,
      color: Colors.pink.shade100,
      animationDuration: const Duration(milliseconds: 350),
      items: const <Widget>[
        Icon(Icons.home_rounded, size: 30),
        Icon(Icons.calendar_today_rounded, size: 30),
      ],
      onTap: onTap,
    );
  }
}
