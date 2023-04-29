import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:marc_project/screens/connexion.dart';
import 'package:marc_project/screens/guide.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final name = nameController.text;
    final city = cityController.text;
    final email = emailController.text;
    final password = passwordController.text;

    // Crypter le mot de passe avec SHA-256
    final bytes = utf8.encode(password); // Convertir le mot de passe en bytes
    final hashedPassword =
        sha256.convert(bytes).toString(); // Hacher le mot de passe

    if (name.isEmpty || city.isEmpty || email.isEmpty || password.isEmpty) {
      // Un ou plusieurs champs sont vides
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 8, 8),
          content: Text('Erreur, données incomplètes ! ❌'),
        ),
      );
      return; // Arrêter l'exécution de la méthode
    }

    final response = await supabase.from('user').insert([
      {'name': name, 'city': city, 'email': email, 'password': hashedPassword}
    ]).execute();

    if (response.error != null) {
      // Échec de l'inscription
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 8, 8),
          content: Text('Erreur, création de compte impossible ! ❌')));
    } else {
      // Inscription réussie, les données ont été insérées dans la table "users"
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 0, 87, 19),
          content: Text('Compte créé avec succès ! ✅')));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Guide()));
    }
  }

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
                    top: 20.0, left: 50, right: 50, bottom: 500),
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
                    Form(
                        key: _formKey,
                        child: Column(
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
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Marc',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez entrer votre prénom';
                                  }
                                  return null;
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
                                controller: cityController,
                                decoration: InputDecoration(
                                  hintText: 'Angers',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez indiquer votre ville';
                                  }
                                  return null;
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
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'marcfaitsescourses@mail.com',
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
                                  // Utilisation d'une expression régulière pour valider le format de l'adresse e-mail.
                                  final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Veuillez entrer une adresse e-mail valide.';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[\w-\.@]+$')),
                                ],
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
                                controller: passwordController,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                    hintText: '***************',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    prefixIcon: Icon(Icons.lock,
                                        color: Constants().secondaryColor),
                                    // Ce bouton est utilisé pour basculer la visibilité du mot de passe
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Constants().secondaryColor),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        })),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez entrer votre mot de passe';
                                  }
                                  if (value.length < 8) {
                                    return 'Le mot de passe doit contenir au moins 8 \ncaractères.';
                                  }
                                  // Utilisation d'une expression régulière pour valider les conditions du mot de passe.
                                  final passwordRegex = RegExp(
                                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()]).{8,}$');
                                  if (!passwordRegex.hasMatch(value)) {
                                    return 'Le mot de passe doit contenir au moins une \nminuscule, une majuscule et un caractère \nspécial.';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[\w!@#$%^&*()]+$')),
                                ],
                              ),
                            ])),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          children: [
                            Text(
                              '* au moins 8 caractères, une minuscule, une majuscule, un caractère spécial',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "RedHatDisplay",
                                  color: Constants().secondaryColor),
                            ),
                          ],
                        )),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register(context);
                        }
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        'Se connecter',
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
