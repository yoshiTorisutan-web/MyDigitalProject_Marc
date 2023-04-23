import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/screens/time_saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Text(
                      'Beaucouzé, ANGERS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay",
                          fontSize: 10,
                          color: Constants().textColorOrange),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.expand_more,
                    color: Constants().iconColor,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
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
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartPage(items: [],)),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/caddie.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TimeSaved()));
                              },
                              icon: const Icon(Icons.chevron_left)),
                          const Text(
                            'Mes commandes',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay"),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tickets de caisses',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay"),
                    ),
                    Container(
                      height: 500,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage('assets/files.png'),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Marc garde tout l\'historique de vos tickets de vos tickets de caisses dans sa poche !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay"),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Vous retrouverez ici de suivi de vos commandes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontFamily: "RedHatDisplay"),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Et l\'ensemble de vos tickets de caisses',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontFamily: "RedHatDisplay"),
                          ),
                        ],
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
