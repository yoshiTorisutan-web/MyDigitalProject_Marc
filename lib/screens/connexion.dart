import 'package:marc_project/constants/constants.dart';
import 'package:marc_project/screens/create_account.dart';
import 'package:marc_project/screens/guide.dart';
import 'package:marc_project/screens/lost_password.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String mail = 'toto49@gmail.com';
  String password = '1234';
  int _currentIndex = 0;

  final List<Widget> _children = [
    const LoginPage(),
    //SignupPage(),
    //ForgotPasswordPage(),
  ];

  void _submitForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Guide()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().primaryColor,
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
                      height: 20), // Espace vertical entre l'image et le texte
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
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, left: 50, right: 50, bottom: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Connectez-vous !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 20,
                            color: Colors.black)),
                    const SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              borderSide: const BorderSide(color: Colors.black),
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
                              borderSide: const BorderSide(color: Colors.black),
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
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => _submitForm(context),
                      // ignore: sort_child_properties_last
                      child: const Text('se connecter',
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
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LostPassword()));
                        },
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            fontFamily: "RedHatDisplay",
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
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
