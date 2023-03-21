import 'package:Marc_project/screens/connexion.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';
  int _currentIndex = 0;

  final List<Widget> _children = [
    const CreateAccount(),
    //SignupPage(),
    //ForgotPasswordPage(),
  ];

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
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 5, 5, 5),
                    radius: 50,
                    backgroundImage: AssetImage('assets/sac-a-main.png'),
                  ),
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
                      const Text("S'inscrire, c'est rapide",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      const SizedBox(height: 25),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Prénom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.black),
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Ville',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.black),
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
                      const SizedBox(height: 30),
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
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(Icons.check_circle,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                size: 14),
                                            SizedBox(width: 8),
                                            Text("Au moins 8 caractères",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Icon(Icons.check_circle,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                size: 14),
                                            SizedBox(width: 8),
                                            Text("Au moins une Minuscule",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(Icons.check_circle,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                size: 14),
                                            SizedBox(width: 8),
                                            Text("Au moins une Majuscule",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Icon(Icons.check_circle,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                size: 14),
                                            SizedBox(width: 8),
                                            Text(
                                                "Au moins un caractère spécial",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 70),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text('ME CONNECTER'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ),
                      Center(
                          child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Créer un compte',
                          style: TextStyle(
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
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.tapas, color: Colors.black),
                label: 'Recettes',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.manage_search, color: Colors.black),
                label: 'Catégories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner, color: Colors.black),
                label: 'Scan',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border, color: Colors.black),
                label: 'Ma liste',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: 'Mon compte',
              ),
            ],
          ),
        ));
  }
}
