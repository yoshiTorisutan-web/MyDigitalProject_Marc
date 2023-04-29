import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header_cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/header.dart';
import 'about_me.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

//Formattage Date d'expiration CB
class CardExpirationInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _formatExpirationDate(newValue.text);
    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection,
    );
  }

  String _formatExpirationDate(String input) {
    String formatted = input.replaceAll(RegExp('[^0-9]'), '');
    if (formatted.length > 2) {
      // ignore: prefer_interpolation_to_compose_strings
      formatted = formatted.substring(0, 2) + '/' + formatted.substring(2);
    }
    if (formatted.length > 5) {
      formatted = formatted.substring(0, 5);
    }
    return formatted;
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _formatCardNumber(newValue.text);
    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection,
    );
  }

  String _formatCardNumber(String input) {
    String formatted = input.replaceAll(RegExp('[^0-9]'), '');
    const int groupSize = 4;
    final List<String> groups = [];

    for (int i = 0; i < formatted.length; i += groupSize) {
      int end = i + groupSize;
      if (end > formatted.length) {
        end = formatted.length;
      }
      groups.add(formatted.substring(i, end));
    }

    if (groups.length > 4) {
      groups.removeRange(4, groups.length);
    }

    return groups.join(' ');
  }
}

//Limiter le nombre du code CVC à 3
class CvcTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3));
    } else {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        'pk_test_51N0jv7GJjR7vmavNnzT4Mqt3jBINr6abZN7c84KPTvfdwTHTLlYfZabWo0pRoBMXXjsuvVikWWT4XivEzSxFb07b00Lt5vs4uu';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Header(),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartPage(
                                      items: [],
                                    )));
                      },
                      icon: const Icon(Icons.close, color: Colors.red,)),
                  const Text(
                    'Annuler',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RedHatDisplay"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Espace de paiement',
                style: TextStyle(fontSize: 20, fontFamily: "RedHatDisplay"),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/carte-bancaire.png'),
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 10),
                    Consumer<UserState>(builder: (context, userState, _) {
                      final userCard = userState.userCard;
                      final userExpirationDate = userState.userExpirationDate;
                      final userCVC = userState.userCVC;
                      return Form(
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
                                        inputFormatters: [
                                          CardNumberInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          hintText: '$userCard',
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
                                                  fontFamily: "RedHatDisplay"),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _expiryDateController,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CardExpirationInputFormatter(),
                                              ],
                                              decoration: InputDecoration(
                                                hintText: '$userExpirationDate',
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
                                                  fontFamily: "RedHatDisplay"),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _cvcController,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CvcTextInputFormatter(),
                                              ],
                                              decoration: InputDecoration(
                                                hintText: '$userCVC',
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
                              const SizedBox(height: 45),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
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
                                        Text('Payez',
                                            style: TextStyle(
                                                fontFamily: "RedHatDisplay")),
                                        Icon(Icons.credit_card),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Image(
                                    image: AssetImage('assets/stripe.png'),
                                    height: 100,
                                    width: 100,
                                  ),
                                ],
                              )
                            ],
                          ));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
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
