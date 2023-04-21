import 'package:marc_project/constants/constants.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  String mail = 'toto49@gmail.com';
  String password = '1234';

  void _submitForm(BuildContext context) {
    // Vérifiez les informations d'identification ici et redirigez vers la page suivante
    // en utilisant Navigator.push
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecipePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            top: -size.width / 1,
            left: -size.width / 2,
            child: Container(
              width: size.width * 2,
              height: size.width * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants().secondaryColor,
              ),
            ),
          ),
          Positioned(
            top: 80,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/MAARC.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                      height: 40), // Espace vertical entre l'image et le texte
                  Text(
                    'Marc, payez, partez !',
                    style: TextStyle(
                        color: Constants().textColor,
                        fontSize: 24,
                        fontFamily: "NiceSugar"),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 275,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, left: 25, right: 25, bottom: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Bienvenue Marie !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 20,
                            color: Colors.black)),
                    const SizedBox(height: 50),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Marc vous fait gagner du temps",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 12,
                                color: Constants().textColorBright)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("A vos marques...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 16,
                                color: Constants().textColor)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "1. Sélectionnez le magasin où vous souhaitez vous rendre",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                                color: Constants().textColor)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "2. Choisisssez la recette que vous souhaitez préparer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                                color: Constants().textColor)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                                color: Constants().textColor),
                            children: const <TextSpan>[
                              TextSpan(
                                  text:
                                      '3. Ajoutez à votre liste de courses les ingrédients qu’il\n'),
                              TextSpan(text: 'vous manque'),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("4. Rendez-vous en magasin",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                                color: Constants().textColor)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("5. Scannez l’ensemble de vos ingrédients",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                                color: Constants().textColor)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("6. Payez et partez !",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 15,
                                color: Constants().textColor)),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => _submitForm(context),
                      // ignore: sort_child_properties_last
                      child: const Text('C\'est parti !',
                          style: TextStyle(fontFamily: "RedHatDisplay")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants().secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
