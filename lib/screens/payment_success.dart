import 'package:flutter/material.dart';
import 'package:marc_project/screens/orders.dart';
import 'package:marc_project/screens/recipes.dart';

import '../constants/constants.dart';

class PaymentSuccesPage extends StatelessWidget {
  const PaymentSuccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'PAIEMENT EFFECTUE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(height: 50),
      const Icon(
        Icons.check_circle,
        color: Color.fromARGB(255, 241, 247, 241),
        size: 100,
      ),
      const SizedBox(height: 100),
      Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Orders()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants().secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('Consulter votre ticket de caisse',
                      style: TextStyle(fontFamily: "RedHatDisplay")),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecipePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants().secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('Revenir à la page des recettes',
                      style: TextStyle(fontFamily: "RedHatDisplay")),
                ],
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}
