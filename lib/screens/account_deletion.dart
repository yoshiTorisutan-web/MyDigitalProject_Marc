import 'package:Marc_project/screens/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'connexion.dart';

class AccountDeletion extends StatefulWidget {
  const AccountDeletion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountDeletionState createState() => _AccountDeletionState();
}

class _AccountDeletionState extends State<AccountDeletion> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const AccountDeletion(),
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
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
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
                                              const AppSetting()));
                                },
                                icon: const Icon(Icons.chevron_left)),
                            const Text(
                              'Paramètre de l\'application',
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
                        'Suppression du compte',
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
                                title: Text(
                                    "Vous souhaitez vraiment supprimer votre compte ?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "RedHatDisplay")),
                                subtitle: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "RedHatDisplay")),
                              ),
                            ],
                          )),
                      const SizedBox(height: 60),
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
                                Text('Supprimer mon compte',
                                    style:
                                        TextStyle(fontFamily: "RedHatDisplay")),
                                Icon(Icons.cancel),
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
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 2.0,
                ),
                bottom: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 2.0,
                ),
                left: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 2.0,
                ),
                right: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 2.0,
                ),
              ),
            ),
            child: const ButtomNavBar()));
  }
}
