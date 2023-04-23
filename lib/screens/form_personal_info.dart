import 'package:flutter/material.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/scan_info.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about_me.dart';

class FormPersonalInfo extends StatefulWidget {
  const FormPersonalInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormPersonalInfoState createState() => _FormPersonalInfoState();
}

class _FormPersonalInfoState extends State<FormPersonalInfo> {
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';
  String numPhone = "02 13 45 67 89";
  String birthday = "01/01/2023";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Text(
                      'Beaucouzé, ANGERS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay",
                          fontSize: 10,
                          color: Constants().textColorOrange),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.expand_more,
                    color: Constants().iconColor,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: <Widget>[
          SizedBox(
            width: 55,
            height: 55,
            child: GestureDetector(
              onTap: () {
                // Action à effectuer lors du clic sur l'image
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartPage(items: [],)),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/caddie.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
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
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AboutMe()));
                              },
                              icon: const Icon(Icons.chevron_left)),
                          const Text(
                            'A propos de moi',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay"),
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
                          fontFamily: "RedHatDisplay",
                          color: Constants().textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Mon identité',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay",
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
                                  fontFamily: "RedHatDisplay",
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
                                    fontFamily: "RedHatDisplay"),
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
                                              fontFamily: "RedHatDisplay"),
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
                                              fontFamily: "RedHatDisplay"),
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
                                    fontFamily: "RedHatDisplay",
                                    color: Constants().secondaryColor),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Adresse mail',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: "RedHatDisplay"),
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
                                    fontFamily: "RedHatDisplay"),
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
                              const SizedBox(height: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FormPersonalInfo()),
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
                                        Text('Enregistrer mes modifications',
                                            style: TextStyle(
                                                fontFamily: "RedHatDisplay")),
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
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScanInfo()));
        },
        elevation: 5,
        backgroundColor: Colors.red,
        child: SvgPicture.asset(
          'assets/scan.svg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
