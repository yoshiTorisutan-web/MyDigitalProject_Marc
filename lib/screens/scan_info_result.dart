import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';

class ScanInfoResult extends StatefulWidget {
  final List<String> scannedProducts;

  const ScanInfoResult({Key? key, required this.scannedProducts})
      : super(key: key);

  @override
  State<ScanInfoResult> createState() => _ScanInfoResultState();
}

class _ScanInfoResultState extends State<ScanInfoResult> {
  List<String> scannedProducts = [];

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
        const SizedBox(height: 35),
        Text(
          'PRODUITS SCANNES',
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
            itemCount: widget.scannedProducts.length,
            itemBuilder: (BuildContext context, int index) {
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
                        widget.scannedProducts[index],
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
                      trailing: Image.asset(
                        'assets/picto-plus.png',
                        width: 24,
                        height: 24,
                      )));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const ScanInfo()),
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
                Text('Scanner d\'autres produits',
                    style: TextStyle(fontFamily: "RedHatDisplay")),
                Icon(Icons.bakery_dining),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants().secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Ajouter à mon panier',
                      style: TextStyle(fontFamily: "RedHatDisplay")),
                  Icon(Icons.shopping_bag),
                ],
              ),
            )),
        const SizedBox(height: 50),
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
