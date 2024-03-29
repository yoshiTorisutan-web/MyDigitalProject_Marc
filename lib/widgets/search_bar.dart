import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../screens/search_ingredients.dart';

//Widget de la barre de recherche présent sur les pages principales de l'application et appeler la classe
//SearchNavBar sur les pages où je veux les afficher pour rechercher un produit par exemple

class SearchNavBar extends StatelessWidget {
  const SearchNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        hintText: 'Lait, fraise, viande...',
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Constants().secondaryColor, width: 2)),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchIngredients()));
      },
    );
  }
}
