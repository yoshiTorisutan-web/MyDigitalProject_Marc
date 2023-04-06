import 'package:Marc_project/screens/orders.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';

class FromPersonalInfo extends StatefulWidget {
  const FromPersonalInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FromPersonalInfoState createState() => _FromPersonalInfoState();
}

class _FromPersonalInfoState extends State<FromPersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';
  String numPhone = "02 13 45 67 89";
  String birthday = "01/01/2023";
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Transform.scale(
            scale: 1.2,
            child: Text(
              'Marc, payez, partez !',
              style: TextStyle(
                  color: Constants().secondaryColor,
                  fontSize: 16,
                  fontFamily: "NiceSugar"),
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
          Positioned(
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                hintText: 'Rechercher',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Constants().secondaryColor, width: 2)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 60,
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
                                        builder: (context) => const Orders()));
                              },
                              icon: const Icon(Icons.arrow_back)),
                          const Text(
                            'A propos de moi',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                    Text(
                      'Infos personnelles',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Constants().textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Mon identité',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Constants().secondaryColor),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Prénom',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
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
                                'Nom',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
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
                                    return 'Veuillez indiquer votre nom';
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Numéro de téléphone',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.black),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez indiquer votre numéro de téléphone';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              numPhone = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Date d\'anniversaire',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.black),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez indiquer votre date d\'anniversaire';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              birthday = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Mes identifiants',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Constants().secondaryColor),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Adresse mail',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
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
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
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
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FromPersonalInfo()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Constants().secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text('ENREGISTRER MES MODIFICATIONS'),
                                        Icon(Icons.done),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Code à exécuter lorsque l'utilisateur appuie sur le bouton flottant
        },
        elevation: 5,
        backgroundColor: Colors.red,
        child: const Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
