import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/constants/constants.dart';
import 'package:marc_project/screens/create_account.dart';
import 'package:marc_project/screens/lost_password.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//Page de "Connexion" permettant à l'utilisateur de se connecter à l'application
//Pour récupérer les données de l'utilisateur, on se connecte à la BDD Supabase pour récupérer le mot de passe
//et l'adresse mail
//Et ainsi, comparé si l'adresse mail et le mot de passe correspond avec ce que l'utilisateur a rempli dans les champs
//Si les 2 éléments correspondent avec la BDD, l'utilisateur peut accéder à l'application

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Fonction qui permet d'établir la connexion de l'utilisateur en fonctions des données transmises par l'utilisateur
  //afin de vérifier si cela "match" bien
  void login(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Un ou plusieurs champs sont vides
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Erreur, e-mail et mot de passe incorrects ! ❌'),
        ),
      );
      return; // Arrêter l'exécution de la méthode
    }

    final bytes = utf8.encode(password);
    final hashedPassword = sha256.convert(bytes).toString();

    final response =
        await supabase.from('user').select().eq('email', email).execute();

    if (response.error != null || response.data.isEmpty) {
      // Échec de la connexion
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Erreur, e-mail et mot de passe incorrects ! ❌'),
        ),
      );
    } else {
      final user = response.data[0];
      final storedHashedPassword = user['password'] as String?;

      if (storedHashedPassword == hashedPassword) {
        // Mot de passe correct, connexion réussie
        // ignore: use_build_context_synchronously
        final userState = context.read<UserState>();
        userState.setUserName(
            user['name'] as String?,
            user['lastname'] as String?,
            user['phone'] as String?,
            user['birthday'] as String?,
            user['email'] as String?,
            user['card'] as String?,
            user['date_expiration'] as String?,
            user['cvc'] as String?);
        userState.setUserLoggedIn(true);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RecipePage(),
          ),
        );
      } else {
        // Mot de passe incorrect
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Erreur, e-mail et mot de passe incorrects ! ❌'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserStateProvider(
        userState: UserState(),
        child: Scaffold(
          backgroundColor: Constants().primaryColor,
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
                        'Marc, payez et partez !',
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
                        const Text("Connectez-vous !",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 20,
                                color: Colors.black)),
                        const SizedBox(height: 40),
                        Form(
                            key: _formKey,
                            child: Column(
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
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                      prefixIcon: Icon(Icons.lock,
                                          color: Constants().secondaryColor),
                                      // Ce bouton est utilisé pour basculer la visibilité du mot de passe
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color:
                                                  Constants().secondaryColor),
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
                            )),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login(context);
                            }
                          },
                          // ignore: sort_child_properties_last
                          child: const Text('se connecter',
                              style: TextStyle(fontFamily: "RedHatDisplay")),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants().secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 10.0),
                          ),
                        ),
                        Center(
                            child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateAccount()));
                          },
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(
                              fontFamily: "RedHatDisplay",
                              decoration: TextDecoration.underline,
                              color: Constants().textColorLink
                            ),
                          ),
                        )),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LostPassword()));
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                decoration: TextDecoration.underline,
                                color: Constants().textColorLink
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
        ));
  }
}
