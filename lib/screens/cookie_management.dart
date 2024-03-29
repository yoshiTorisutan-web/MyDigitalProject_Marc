import 'package:marc_project/screens/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';

//Page de "Cookies" permettant à l'utilisateur d'expliquer ce que c'est les cookies et comment sont ils générer
//dans l'application.

class CookieManagement extends StatefulWidget {
  const CookieManagement({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CookieManagementState createState() => _CookieManagementState();
}

class _CookieManagementState extends State<CookieManagement> {
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
          Positioned(
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
                                            const AppSetting()));
                              },
                              icon: const Icon(Icons.chevron_left)),
                          const Text(
                            'Paramètres de l\'application',
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
                      'Gestion des cookies',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay"),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView(
                          padding: const EdgeInsets.only(top: 10),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const ListTile(
                              title: Text("Personnaliser mes cookies !",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              subtitle: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                  style: TextStyle(
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10)),
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              title: const Text("Les cookies essentiels",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              subtitle: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                  style: TextStyle(
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10)),
                              trailing: Icon(Icons.toggle_on,
                                  color: Constants().secondaryColor),
                            ),
                            ListTile(
                              title: const Text("Les cookies marketing",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              subtitle: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                  style: TextStyle(
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10)),
                              trailing: Icon(Icons.toggle_off,
                                  color: Constants().secondaryColor),
                            ),
                            ListTile(
                              title: const Text("Les cookies de notifications",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              subtitle: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                  style: TextStyle(
                                      fontFamily: "RedHatDisplay",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 10)),
                              trailing: Icon(Icons.toggle_off,
                                  color: Constants().secondaryColor),
                            ),
                          ],
                        )),
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
