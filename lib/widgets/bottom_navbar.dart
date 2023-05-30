import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constants.dart';

//Widget BottomAppBar présent sur les pages principales de l'application et appeler la classe
//ButtomNavBar sur les pages où je veux les afficher

class ButtomNavBar extends StatefulWidget {
  const ButtomNavBar({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour _selectedIndex selon la page courante
    _updateSelectedIndex();
  }
  
  //Affichage de l'icône de couleur dans la barre de navigation en bas de page différente en fonction de la page active
  void _updateSelectedIndex() {
    if (ModalRoute.of(context)?.settings.name == '/recipes') {
      setState(() {
        _selectedIndex = 0;
      });
    } else if (ModalRoute.of(context)?.settings.name == '/categoriesProducts') {
      setState(() {
        _selectedIndex = 1;
      });
    } else if (ModalRoute.of(context)?.settings.name == '/mylist') {
      setState(() {
        _selectedIndex = 2;
      });
    } else if (ModalRoute.of(context)?.settings.name == '/account') {
      setState(() {
        _selectedIndex = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Constants().primaryColor,
      notchMargin: 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ? Constants().iconColor
                    : Constants().textColor,
              ),
              tooltip: 'RECETTES',
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pushNamed(context, '/recipes');
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
                color: _selectedIndex == 1
                    ? Constants().iconColor
                    : Constants().textColor,
              ),
              tooltip: 'CATEGORIES',
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pushNamed(context, '/categoriesProducts');
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
                'assets/liste.svg',
                width: 24,
                height: 24,
                color: _selectedIndex == 2
                    ? Constants().iconColor
                    : Constants().textColor,
              ),
              tooltip: 'MA LISTE',
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pushNamed(context, '/mylist');
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
                color: _selectedIndex == 3
                    ? Constants().iconColor
                    : Constants().textColor,
              ),
              tooltip: 'MON COMPTE',
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pushNamed(context, '/account');
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
