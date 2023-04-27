import 'package:marc_project/screens/create_account.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LostPassword extends StatefulWidget {
  const LostPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LostPasswordState createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  final TextEditingController emailController = TextEditingController();

  void sendPasswordResetEmail(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final email = emailController.text;

    if (email.isEmpty) {
      // L'utilisateur n'a pas fourni d'e-mail
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Veuillez fournir votre adresse e-mail.'),
        ),
      );
      return;
    }

    final response = await supabase.auth.api.resetPasswordForEmail(email);

    if (response.error != null) {
      // Une erreur s'est produite lors de l'envoi de l'e-mail de récupération
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Une erreur s\'est produite. Veuillez réessayer.'),
        ),
      );
    } else {
      // L'e-mail de récupération a été envoyé avec succès
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Un e-mail de récupération a été envoyé à $email.'),
        ),
      );
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
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => sendPasswordResetEmail(context),
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
