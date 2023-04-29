import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header_cart.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/header.dart';
import 'about_me.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoState createState() => _PersonalInfoState();
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

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserCardData();
  }

  //Récupération données utilisateurs
  Future<void> getUserCardData() async {
    final supabase = Supabase.instance.client;
    final currentUser = supabase.auth.currentUser;

    if (currentUser != null) {
      final response = await supabase
          .from('user')
          .select()
          .eq('email', currentUser.email)
          .execute();

      if (response.error == null && response.data != null) {
        final userData = response.data as List<dynamic>;
        if (userData.isNotEmpty) {
          final user = userData.first;
          _cardNumberController.text = user['card'];
          _expiryDateController.text = user['date_expiration'];
          _cvcController.text = user['cvc'];
        }
      }
    }
  }

  //Mise à jour des données utilisateurs
  Future<void> _saveForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final supabase = Supabase.instance.client;
      final userState = context.read<UserState>();

      if (userState.isUserLoggedIn) {
        final updatedData = {
          'card': _cardNumberController.text,
          'date_expiration': _expiryDateController.text,
          'cvc': _cvcController.text,
        };

        final loggedInUserEmail =
            userState.userEmail; // Access the user's email

        supabase
            .from('user')
            .update(updatedData)
            .eq('email', loggedInUserEmail)
            .execute()
            .then((response) {
          if (response.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 8, 8),
              content: Text('Erreur, l\'ajout de carte bancaire a échoué ! ❌'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 0, 87, 19),
              content: Text('Votre carte a bien été ajouté ! ✅'),
            ));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PersonalInfo()),
            );
          }
        });
      } else {
        // Handle the case where the user is not logged in
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 8, 8),
          content: Text('Erreur, vous n\'êtes pas connecté ! ❌'),
        ));
      }
    }
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
        actions: const <Widget>[HeaderCart()],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
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
                      'Carte de paiement',
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
                          const SizedBox(height: 10),
                          Consumer<UserState>(builder: (context, userState, _) {
                            final userCard = userState.userCard;
                            final userExpirationDate =
                                userState.userExpirationDate;
                            final userCVC = userState.userCVC;
                            return Form(
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
                                              keyboardType:
                                                  TextInputType.number,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "RedHatDisplay"),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  TextFormField(
                                                    controller:
                                                        _expiryDateController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      CardExpirationInputFormatter(),
                                                    ],
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          '$userExpirationDate',
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey[200],
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "RedHatDisplay"),
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
                                                      fillColor:
                                                          Colors.grey[200],
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
                                            _saveForm(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Constants().secondaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const <Widget>[
                                              Text('Ajouter ma carte bancaire',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "RedHatDisplay")),
                                              Icon(Icons.done),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '⚠️ redémarrer l\'application pour voir vos votre carte ajouté !',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "RedHatDisplay",
                                                color:
                                                    Constants().secondaryColor),
                                          ),
                                        )
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
