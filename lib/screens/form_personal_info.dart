import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about_me.dart';

//Page de "Modification de compte" permettant à l'utilisateur de modifier et de compléter ses informations sur l'application
//Pour enregistrer les données modifiées de l'utilisateur, on se connecte à la BDD Supabase pour enregistrer et modifier son nom, sa ville,
//son adresse mail, son mot de passe, son nom, sa date de naissance et son numéro de téléphone
//Néanmoins, l'utilisateur devra quitter et revenir sur l'application pour voir les modifications effectuées

class FormPersonalInfo extends StatefulWidget {
  const FormPersonalInfo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormPersonalInfoState createState() => _FormPersonalInfoState();
}

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    if (newTextLength >= 3) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 2)}/');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newTextLength >= 5) {
      newText.write('${newValue.text.substring(2, usedSubstringIndex = 4)}/');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex) {
      final String year = newValue.text.substring(usedSubstringIndex);
      if (year.length > 4) {
        newText.write(year.substring(0, 4));
      } else {
        newText.write(year);
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class _FormPersonalInfoState extends State<FormPersonalInfo> {
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // Fonction qui récupère les infos de l'utilisateur connecté sur l'application
  Future<void> getUserData() async {
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
          _nameController.text = user['name'];
          _lastnameController.text = user['lastname'];
          _phoneController.text = user['phone'];
          _birthdayController.text = user['birthday'];
          _emailController.text = user['email'];
        }
      }
    }
  }
 
  // Fonction qui modifie et envoi les infos de l'utilisateur connecté sur l'application via un formulaire
  Future<void> _saveForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final supabase = Supabase.instance.client;
      final userState = context.read<UserState>();

      if (userState.isUserLoggedIn) {
        final updatedData = {
          'name': _nameController.text,
          'lastname': _lastnameController.text,
          'phone': _phoneController.text,
          'birthday': _birthdayController.text,
          'email': _emailController.text,
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
              content: Text(
                  'Erreur, les modifications n\'ont pas été enregistrées ! ❌'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 0, 87, 19),
              content: Text('Modifications enregistrées avec succès ! ✅'),
            ));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FormPersonalInfo()),
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
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 100),
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
                    child:
                        Consumer<UserState>(builder: (context, userState, _) {
                      final userName = userState.userName;
                      final userLastname = userState.userLastname;
                      final userPhone = userState.userPhone;
                      final userBirthday = userState.userBirthday;
                      final userEmail = userState.userEmail;
                      return Form(
                          key: _formKey,
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
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: '$userName',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre prénom';
                                    }
                                    return null;
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
                                  controller: _lastnameController,
                                  decoration: InputDecoration(
                                    hintText: '$userLastname',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre nom';
                                    }
                                    return null;
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
                                              fontFamily: "RedHatDisplay",
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            controller: _phoneController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              // Limit the input to 10 digits
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                            ],
                                            decoration: InputDecoration(
                                              hintText: '$userPhone',
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
                                              if (value!.isEmpty) {
                                                return 'Veuillez entrer votre numéro de téléphone';
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
                                            'Date de naissance',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: "RedHatDisplay",
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            controller: _birthdayController,
                                            keyboardType:
                                                TextInputType.datetime,
                                            inputFormatters: [
                                              // Format the input as DD/MM/YYYY
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              DateTextInputFormatter(),
                                            ],
                                            decoration: InputDecoration(
                                              hintText: '$userBirthday',
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
                                              if (value!.isEmpty) {
                                                return 'Veuillez entrer votre date de naissance';
                                              }
                                              return null;
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
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: '$userEmail',
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
                                      fontFamily: "RedHatDisplay"),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                      hintText: '************************',
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
                                ),
                                const SizedBox(height: 20),
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
                                            horizontal: 20.0, vertical: 10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const <Widget>[
                                          Text('Enregistrer mes modifications',
                                              style: TextStyle(
                                                  fontFamily: 'RedHatDisplay')),
                                          Icon(Icons.done),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        '⚠️ redémarrer l\'application pour voir vos informations modifier !',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "RedHatDisplay",
                                            color: Constants().secondaryColor),
                                      ),
                                    )
                                  ],
                                )
                              ]));
                    }))
              ],
            ),
          ),
        ),
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
