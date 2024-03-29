import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/constants/constants.dart';
import 'package:marc_project/screens/pay.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/bottom_navbar.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import 'package:marc_project/widgets/search_bar.dart';
import 'package:provider/provider.dart';

//Page "Mon Panier" qui récapitule les 

class CartPage extends StatelessWidget {
  final List<dynamic> items;

  const CartPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<UserState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Header(),
        actions: const <Widget>[HeaderCart()],
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SearchNavBar(),
        ),
        const SizedBox(height: 20),
        Text(
          'MON PANIER',
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
            itemCount: items.length,
            itemBuilder: (context, index) {
              const itemPrice = 2.99; // Prix de l'article

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Image.network(
                    items[index]['image'],
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                  title: Text(
                    items[index]['title'],
                    style: const TextStyle(
                        fontFamily: "RedHatDisplay",
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "2.99 €",
                    style: TextStyle(
                        fontFamily: "RedHatDisplay",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (cart.totalPrice >= itemPrice) {
                            cart.removeFromCart(itemPrice);
                          }
                        },
                        child: Image.asset(
                          'assets/moins.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${cart.totalPrice.toString()} €',
                        style: const TextStyle(
                          fontFamily: "RedHatDisplay",
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          cart.addToCart(itemPrice);
                        },
                        child: Image.asset(
                          'assets/plus.png',
                          width: 16,
                          height: 16,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Prix total : ${cart.totalPrice.toStringAsFixed(2)} €',
            style: const TextStyle(
              fontFamily: "RedHatDisplay",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PayPage()));
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Payez mon panier !',
                    style: TextStyle(fontFamily: "RedHatDisplay")),
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
