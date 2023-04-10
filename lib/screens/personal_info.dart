import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';
import 'about_me.dart';

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
            width: 55,
            height: 55,
            child: GestureDetector(
              onTap: () {
                // Action à effectuer lors du clic sur l'image
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: SvgPicture.asset(
                  'assets/caddie.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned(left: 20, right: 20, child: SearchNavBar()),
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
                    const Text(
                      'Infos personnelles',
                      style:
                          TextStyle(fontSize: 20, fontFamily: "RedHatDisplay"),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Ajouter mon moyen de paiement',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "RedHatDisplay",
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
                                            fontFamily: "RedHatDisplay",
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
                                                    fontFamily:
                                                        "RedHatDisplay"),
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
                                                    fontFamily:
                                                        "RedHatDisplay"),
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
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PersonalInfo()),
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
                                          Text('Ajouter ma carte bancaire',
                                              style: TextStyle(
                                                  fontFamily: "RedHatDisplay")),
                                          Icon(Icons.done),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
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
      bottomNavigationBar: const ButtomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Annuler", true, ScanMode.BARCODE);
          print(barcodeScanRes);
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
