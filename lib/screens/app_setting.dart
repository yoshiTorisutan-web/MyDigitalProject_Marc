import 'package:Marc_project/screens/account_deletion.dart';
import 'package:Marc_project/screens/connexion.dart';
import 'package:Marc_project/screens/cookie_management.dart';
import 'package:Marc_project/screens/time_saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';


class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppSettingState createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const AppSetting(),
    //SignupPage(),
    //ForgotPasswordPage(),
  ];

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
          Positioned(
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                hintText: 'Rechercher',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Constants().secondaryColor, width: 2)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          Positioned(
            top: 50,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TimeSaved()));
                              },
                              icon: const Icon(Icons.chevron_left)),
                          const Text(
                            'A propos de moi',
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
                    const SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      shape: const Border(
                          bottom: BorderSide(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Gestion des cookies',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "RedHatDisplay"),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CookieManagement()));
                                },
                                icon: Icon(Icons.chevron_right, color: Constants().secondaryColor))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: const Border(
                          bottom: BorderSide(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Suppression de compte',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "RedHatDisplay"),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AccountDeletion()));
                                },
                                icon: Icon(Icons.chevron_right, color: Constants().secondaryColor,))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 350),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
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
        onPressed: () {
          // Code à exécuter lorsque l'utilisateur appuie sur le bouton flottant
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
