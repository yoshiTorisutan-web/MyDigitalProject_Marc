import 'package:marc_project/screens/create_account.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LostPassword extends StatefulWidget {
  const LostPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LostPasswordState createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  final _formKey = GlobalKey<FormState>();
  String username = 'Toto49';
  String password = '1234';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Vérifiez ici les informations d'identification de l'utilisateur
      // et connectez-le à l'application si les informations sont valides.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Positioned(
              top: 40,
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
                        height:
                            20), // Espace vertical entre l'image et le texte
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
              top: 250,
              left: 10,
              right: 10,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0, left: 50, right: 50, bottom: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Marc, on a un oubli ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "RedHatDisplay",
                              fontSize: 20,
                              color: Colors.black)),
                      const SizedBox(height: 10),
                      const Text("Redéfinissez votre mot de passe.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "RedHatDisplay",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      const SizedBox(height: 50),
                      const Text(
                          "Vous allez recevoir un e-mail vous permettant de modifier votre mot de passe.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "RedHatDisplay",
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black)),
                      const SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Adresse mail",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: "RedHatDisplay",
                              )),
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
                                username = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _submitForm,
                        // ignore: sort_child_properties_last
                        child: const Text('envoyer',
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateAccount()));
                        },
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
        ));
  }
}
