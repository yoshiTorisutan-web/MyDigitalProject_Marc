import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/categories_products.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/bottom_navbar.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';

import '../constants/constants.dart';
import '../widgets/search_bar.dart';

class SelectedIngredientsPage extends StatefulWidget {
  final List<String> selectedIngredients;

  const SelectedIngredientsPage({Key? key, required this.selectedIngredients})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SelectedIngredientsPageState createState() =>
      _SelectedIngredientsPageState();
}

class _SelectedIngredientsPageState extends State<SelectedIngredientsPage> {
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
          'LISTE D\'INGREDIENTS',
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
            itemCount: widget.selectedIngredients.length,
            itemBuilder: (context, index) {
              final ingredient = widget.selectedIngredients[index];
              return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Image(
                      image: AssetImage('assets/aliments.png'),
                      width: 80,
                      height: 80,
                    ),
                    title: Text(
                      ingredient,
                      style: TextStyle(
                          fontFamily: "RedHatDisplay",
                          fontSize: 16,
                          color: Constants().textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Ingrédients",
                      style: TextStyle(
                          fontFamily: "RedHatDisplay",
                          fontSize: 12,
                          color: Constants().textColorBright,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/caddie_shop.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryListPage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/search.png',
                            width: 24,
                            height: 24,
                          ),
                        )
                      ],
                    ),
                    onTap: () {},
                  ));
            },
          ),
        )
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
