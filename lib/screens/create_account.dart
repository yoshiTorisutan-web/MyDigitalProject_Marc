import 'package:marc_project/screens/guide.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            top: -size.width / 1,
            left: -size.width / 2,
            child: Container(
              width: size.width * 2,
              height: size.width * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants().secondaryColor,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
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
                      height: 40), // Espace vertical entre l'image et le texte
                  Text(
                    'Marc, payez, partez !',
                    style: TextStyle(
                        color: Constants().textColor,
                        fontSize: 24,
                        fontFamily: "NiceSugar"),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 275,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, left: 50, right: 50, bottom: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("S'inscrire, c'est rapide",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 20,
                            color: Colors.black)),
                    const SizedBox(height: 25),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Prénom',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "RedHatDisplay",
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prénom',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prénom';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Ville',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "RedHatDisplay",
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Ville',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez indiquer votre ville';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                city = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Adresse mail',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "RedHatDisplay",
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Adresse mail',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre adresse mail';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                mail = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Mot de passe',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "RedHatDisplay",
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          children: [
                            Text(
                              '*au moins 8 caractères, une minuscule, une majuscule, un caractère spécial',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "RedHatDisplay",
                                  color: Constants().secondaryColor),
                            ),
                          ],
                        )),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Guide()));
                      },
                      // ignore: sort_child_properties_last
                      child: const Text('s\'inscrire',
                          style: TextStyle(fontFamily: "RedHatDisplay")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10.0),
                      ),
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Créer un compte',
                        style: TextStyle(
                          fontFamily: "RedHatDisplay",
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
