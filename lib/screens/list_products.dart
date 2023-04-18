import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:marc_project/screens/recipes.dart';

import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final url = Uri.parse(
        'https://api.spoonacular.com/food/products/search?apiKey=e7d8103d0f674050924ec567074b3e0a&query=fruit');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      _products = data['products'];
    });
  }

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
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SearchNavBar(),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecipePage()));
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
        const SizedBox(height: 20),
        Text(
          'FRUITS ET LEGUMES',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: "RedHatDisplay",
              color: Constants().secondaryColor),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                      leading: Image.network(
                        _products[index]['image'],
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                      title: Text(
                        _products[index]['title'],
                        style: TextStyle(
                            fontFamily: "RedHatDisplay",
                            fontSize: 12,
                            color: Constants().textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("2.99 €",
                          style: TextStyle(
                              fontFamily: "RedHatDisplay",
                              fontSize: 16,
                              color: Constants().textColorBright,
                              fontWeight: FontWeight.bold)),
                      trailing: const Icon(Icons.add)));
            },
          ),
        )
      ]),
      bottomNavigationBar: const ButtomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Annuler", true, ScanMode.BARCODE);
          // ignore: avoid_print
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