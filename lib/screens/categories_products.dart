import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/products_categories/bakery.dart';
import 'package:marc_project/screens/products_categories/dairy_products.dart';
import 'package:marc_project/screens/products_categories/fresh_products.dart';
import 'package:marc_project/screens/products_categories/frozen_products.dart';
import 'package:marc_project/screens/products_categories/fruits_and_vegetables.dart';
import 'package:marc_project/screens/products_categories/groceries.dart';
import 'package:marc_project/screens/products_categories/meat_and_fish.dart';
import 'package:marc_project/screens/products_categories/non_alcoholic_beverages.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import '../constants/constants.dart';
import '../models/categories.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';

//Page de "Catégories de produits" présentant les différents catégories de produits comme par exemple
//les produits frais, fruits et légumes, etc.

class CategoryListPage extends StatelessWidget {
  //Liste des catégories de produits stockées en brut
  final List<Category> categories = [
    Category("PRODUITS LAITIERS", const DairyProductsPage()),
    Category("FRUITS & LEGUMES", const FruitsAndVegetablesPage()),
    Category("VIANDES & POISSONS", const MeatAndFishPage()),
    Category("PRODUITS FRAIS", const FreshProductsPage()),
    Category("PRODUITS SURGELES", const FrozenProductsPage()),
    Category("BOISSONS (NON) ALCOOLISEES", const NonAlcoholicBeveragesPage()),
    Category("PAINS, VIENNOISERIES & PATISSERIES", const BakeryPage()),
    Category("EPICERIES", const GroceriesPage()),
  ];

  CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Header(),
        actions: const <Widget>[
          HeaderCart()
        ],
      ),
      body: Stack(
        children: [
          const Positioned(left: 20, right: 20, child: SearchNavBar()),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            bottom: 1, // reduce the bottom value
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RecipePage()));
                            },
                            icon: Icon(Icons.chevron_left,
                                color: Constants().secondaryColor)),
                        Text('Revenir à la page précédente',
                            style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: 12,
                                color: Constants().secondaryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: ListView.separated(
                          itemCount: categories.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Constants().secondaryColor,
                              height: 2.0,
                              thickness: 1.0,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                categories[index].name,
                                style: TextStyle(
                                  fontFamily: "RedHatDisplay",
                                  color: Constants().secondaryColor,
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Constants().secondaryColor,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          categories[index].page),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

//Bouton permettant de rediriger vers la page de scan.

      bottomNavigationBar: const ButtomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScanInfo()));
        },
        elevation: 5,
        backgroundColor: Colors.red,
        child: SvgPicture.asset(
          'assets/scan.svg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
