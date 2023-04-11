import 'package:marc_project/screens/connexion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/recipes.dart';
import '../constants/constants.dart';
import '../models/categories.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'list_products.dart';

class CategoryListPage extends StatelessWidget {
  final List<Category> categories = [
    Category("PRODUITS LAITIERS"),
    Category("FRUITS & LEGUMES"),
    Category("VIANDES & POISSONS"),
    Category("PRODUITS FRAIS"),
    Category("PRODUITS SURGELES"),
    Category("BOISSONS (NON) ALCOOLISES"),
    Category("PAINS, VIENNOISERIES & PATISSERIES"),
    Category("HIGH TECH"),
  ];

  CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Transform.scale(
            scale: 1.2,
            child: Text(
              'Marc, payez, partez !',
              style: TextStyle(
                  color: Constants().secondaryColor,
                  fontSize: 16,
                  fontFamily: "NiceSugar"),
            ),
          ),
        ),
        actions: <Widget>[
          SizedBox(
            width: 55,
            height: 55,
            child: GestureDetector(
              onTap: () {
                // Action à effectuer lors du clic sur l'image
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: SvgPicture.asset(
                  'assets/caddie.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
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
                              color: Colors.grey[800],
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
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ProductsPage()));
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
      bottomNavigationBar: const ButtomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Annuler", true, ScanMode.BARCODE);
          print(barcodeScanRes);
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
