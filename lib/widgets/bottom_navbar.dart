import 'package:flutter/material.dart';

class ButtomNavBar extends StatefulWidget {
  const ButtomNavBar({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        children: [
          const SizedBox(
            width: 30.0,
          ),
          IconButton(
            icon: const Icon(Icons.tapas),
            tooltip: 'RECETTES',
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          const SizedBox(
            width: 30.0,
          ),
          IconButton(
            icon: const Icon(Icons.manage_search),
            tooltip: 'CATEGORIES',
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const SizedBox(
            width: 110.0,
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'MA LISTE',
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
          const SizedBox(
            width: 30.0,
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'MON COMPTE',
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
