import 'package:Marc_project/screens/connexion.dart';
import 'package:flutter/material.dart';

class TimeSaved extends StatefulWidget {
  const TimeSaved({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeSavedState createState() => _TimeSavedState();
}

class _TimeSavedState extends State<TimeSaved> {
  final _formKey = GlobalKey<FormState>();
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';
  int _currentIndex = 0;

  final List<Widget> _children = [
    const TimeSaved(),
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Transform.scale(
              scale: 1.2,
              child: const Text(
                'Marc, payez, partez !',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                padding: const EdgeInsets.only(right: 45),
                icon: Transform.scale(
                  scale: 1.2,
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 24,
                  ),
                ),
                color: Colors.black,
                tooltip: 'Comment Icon',
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            const Positioned(
              top: 10,
              left: 30,
              right: 0,
              child: Text("Mon compte",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
            ),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 50, right: 50, bottom: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 5, 5, 5),
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/sac-a-main.png'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Marc, vous aide !',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text("Temps économisé",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text("A vos marques",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text("vous avez économisé",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text("1H",
                                            style: TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        SizedBox(width: 8),
                                        Icon(Icons.watch_later,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            size: 30),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
