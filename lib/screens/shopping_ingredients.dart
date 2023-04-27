import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/bottom_navbar.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';

import '../constants/constants.dart';
import '../widgets/search_bar.dart';
import 'categories_products.dart';

class SelectedProductsScreen extends StatefulWidget {
  final List<dynamic> items;

  const SelectedProductsScreen({Key? key, required this.items})
      : super(key: key);

  @override
  State<SelectedProductsScreen> createState() => _SelectedProductsScreenState();
}

class _SelectedProductsScreenState extends State<SelectedProductsScreen> {
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
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SearchNavBar(),
        ),
        const SizedBox(height: 20),
        Text(
          'LISTE DE PRODUITS',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: "RedHatDisplay",
              color: Constants().secondaryColor),
        ),
        Expanded(
          child: ListView.builder(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Image.network(
                    widget.items[index]['image'],
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                  title: Text(
                    widget.items[index]['title'],
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: const Color.fromARGB(127, 244, 67, 54),
                    onPressed: () {
                      setState(() {
                        widget.items.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => CategoryListPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants().secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Ajouter d\'autres produits',
                    style: TextStyle(fontFamily: "RedHatDisplay")),
                Icon(Icons.bakery_dining),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(items: widget.items),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants().secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Ajouter les produits à mon panier',
                    style: TextStyle(fontFamily: "RedHatDisplay")),
                Icon(Icons.shopping_bag),
              ],
            ),
          ),
        ),
        const SizedBox(height: 50)
      ]),
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
