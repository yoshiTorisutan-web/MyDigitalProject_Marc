import 'package:marc_project/screens/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constants.dart';
import '../screens/categories_products.dart';
import '../screens/time_saved.dart';

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
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/recipes.svg',
                width: 24,
                height: 24,
                color: _selectedIndex == 0
                    ? Constants().secondaryColor
                    : Constants().textColor,
              ),
              tooltip: 'RECETTES',
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecipePage()));
              },
            ),
          ),
          const SizedBox(
            width: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/search.svg',
                width: 24,
                height: 24,
                color: _selectedIndex == 0
                    ? Constants().secondaryColor
                    : Constants().textColor,
              ),
              tooltip: 'CATEGORIES',
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryListPage()));
              },
            ),
          ),
          const SizedBox(
            width: 110.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/favori.svg',
                width: 24,
                height: 24,
                color: _selectedIndex == 0
                    ? Constants().secondaryColor
                    : Constants().textColor,
              ),
              tooltip: 'MA LISTE',
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ),
          const SizedBox(
            width: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/compte.svg',
                width: 24,
                height: 24,
                color: _selectedIndex == 0
                    ? Constants().secondaryColor
                    : Constants().textColor,
              ),
              tooltip: 'MON COMPTE',
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TimeSaved()));
              },
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
