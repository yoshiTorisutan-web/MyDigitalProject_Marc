import 'package:Marc_project/screens/app_setting.dart';
import 'package:flutter/material.dart';

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
                                icon: const Icon(Icons.arrow_back)),
                            const Text(
                              'Paramètre de l\'application',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 20),
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
                                title: Text("Vous êtes sûr de supprimer votre compte ?",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0))),
                                subtitle: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 10)),
                              ),
                            ],
                          )),
                      const SizedBox(height: 60),
                      Card(
                        color: const Color.fromARGB(213, 239, 111, 111),
                        shape: const Border(
                            bottom: BorderSide(color: Colors.black, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                child: Text(
                                  'Supprimer mon compte',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
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
