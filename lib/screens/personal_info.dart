import 'package:Marc_project/screens/orders.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  int _currentIndex = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvcController = TextEditingController();

  final List<Widget> _children = [
    const PersonalInfo(),
    //SignupPage(),
    //ForgotPasswordPage(),
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
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
                                              const Orders()));
                                },
                                icon: const Icon(Icons.arrow_back)),
                            const Text(
                              'Mes commandes',
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
                        'Infos personnelles',
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/carte-bancaire.png'),
                              height: 200,
                              width: 200,
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'Ajouter mon moyen de paiement',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Numéro de votre carte',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            controller: _cardNumberController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: '01234567891011',
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Veuillez entrer un numéro de carte bancaire valide';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
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
                                                  'Date d\'expiration',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                TextFormField(
                                                  controller:
                                                      _expiryDateController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: '00/00',
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Veuillez entrer une date d\'expiration valide';
                                                    }
                                                    return null;
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
                                                  'Code CVC',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                TextFormField(
                                                  controller: _cvcController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: '000',
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Veuillez entrer un code CVC valide';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .validate()) {}
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                      ),
                                      child: const Text(
                                          'AJOUTER MA CARTE BANCAIRE'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
