import 'package:marc_project/screens/app_setting.dart';
import 'package:marc_project/screens/connexion.dart';
import 'package:marc_project/screens/list_supermarket.dart';
import 'package:marc_project/screens/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'about_me.dart';

//Page permettant à l'utilisateur de connaître le temps qu'il a pu économiser pour faire ses courses grâce à l'application
//comparé à quelqu'un qui fait ses courses de manière traditionnnel
//Et également, naviguer sur différentes pages de mon compte et des paramètres.

class TimeSaved extends StatefulWidget {
  final String? userName;

  const TimeSaved({super.key, this.userName});

  @override
  // ignore: library_private_types_in_public_api
  _TimeSavedState createState() => _TimeSavedState();
}

class _TimeSavedState extends State<TimeSaved> {

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
            top: 0,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/MAARC.svg',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                              height:
                                  20), // Espace vertical entre l'image et le texte
                          Text(
                            'Marc.',
                            style: TextStyle(
                                color: Constants().textColor,
                                fontSize: 24,
                                fontFamily: "NiceSugar"),
                          ),
                          Text(
                            'vous apporte son aide !',
                            style: TextStyle(
                                color: Constants().textColor,
                                fontSize: 18,
                                fontFamily: "NiceSugar"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text("Temps économisé",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "RedHatDisplay",
                                              color: Colors.black)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: const [
                                      Text("Grâce à Marc, vos courses sont",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: "RedHatDisplay")),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: const [
                                      Text("bien plus agréable et rapide",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "RedHatDisplay",
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Row(
                                        children: [
                                          const Text("1H",
                                              style: TextStyle(
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          const SizedBox(width: 8),
                                          SvgPicture.asset(
                                            'assets/time.svg',
                                            width: 50,
                                            height: 50,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Card(
                      elevation: 0,
                      shape: const Border(
                          bottom: BorderSide(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Ma géolocalisation',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SupermarketList()));
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Constants().secondaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: const Border(
                          bottom: BorderSide(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Mes commandes',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Orders()));
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Constants().secondaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: const Border(
                          bottom: BorderSide(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'A propos de moi',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AboutMe()));
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Constants().secondaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: const Border(
                          bottom: BorderSide(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Paramètres de l\'application',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AppSetting()));
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Constants().secondaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Supabase.instance.client.auth.signOut();
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text('Déconnexion',
                                  style:
                                      TextStyle(fontFamily: "RedHatDisplay")),
                              Icon(Icons.logout),
                            ],
                          ),
                        ),
                      ],
                    )
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
