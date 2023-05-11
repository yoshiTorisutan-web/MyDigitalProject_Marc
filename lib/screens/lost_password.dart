import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:marc_project/screens/connexion.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Page "Récupération de mot de passe" permet à l'utilisateur de récupérer son mot de passe s'il l'a oublié
//Il devra rentrer son email (avec celui qui lui a permis de créer son compte) afin de recevoir un email lui permettant
//de changer son mot de passe

class LostPassword extends StatefulWidget {
  const LostPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LostPasswordState createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void updatePassword(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final email = emailController.text.trim();
    final newPassword = passwordController.text.trim();

    // Crypter le mot de passe avec SHA-256
    final bytes =
        utf8.encode(newPassword); // Convertir le mot de passe en bytes
    final hashedPassword =
        sha256.convert(bytes).toString(); // Hacher le mot de passe

    final response =
        await supabase.from('user').select().eq('email', email).execute();

    if (response.error != null) {
      // Erreur lors de la recherche de l'e-mail
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: Text(response.error!.message),
        ),
      );
    } else {
      final data = response.data as List<dynamic>;

      if (data.isNotEmpty) {
        // L'e-mail existe, mettez à jour le mot de passe
        final updateResponse = await supabase
            .from('user')
            .update({'password': hashedPassword})
            .eq('email', email)
            .execute();

        if (updateResponse.error != null) {
          // Erreur lors de la mise à jour du mot de passe
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Erreur'),
              content: Text(updateResponse.error!.message),
            ),
          );
        } else {
          // Mot de passe mis à jour avec succès
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Succès ✅',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RedHatDisplay")),
              content: Text('Le mot de passe a été mis à jour avec succès.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RedHatDisplay")),
            ),
          );
        }
      } else {
        // L'e-mail n'existe pas dans la base de données
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Erreur ❌',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "RedHatDisplay")),
            content: Text("L'adresse e-mail fournie n'existe pas.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "RedHatDisplay")),
          ),
        );
      }
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
                        height:
                            40), // Espace vertical entre l'image et le texte
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
                              final emailRegex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => updatePassword(context),
                        // ignore: sort_child_properties_last
                        child: const Text('Mettre à jour le mot de passe',
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
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                            fontFamily: "RedHatDisplay",
                            decoration: TextDecoration.underline,
                            color: Constants().textColorLink
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
