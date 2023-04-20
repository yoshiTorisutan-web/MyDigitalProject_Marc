import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/scan_info_result.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanInfo extends StatefulWidget {
  const ScanInfo({super.key});

  @override
  State<ScanInfo> createState() => _ScanInfoState();
}

class _ScanInfoState extends State<ScanInfo> {
  List<String> scannedProducts = [];

  Future<void> _scanBarcode() async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Annuler", true, ScanMode.BARCODE);
      setState(() {
        scannedProducts.add(barcode);
      });
    } catch (e) {
      setState(() {
        scannedProducts.add("Erreur inconnue: $e");
      });
    }
  }

  void _goToScannedProductsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanInfoResult(scannedProducts: scannedProducts),
      ),
    );
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
          Positioned(
            top: 35,
            left: 20,
            right: 20,
            bottom: 425, // reduce the bottom value
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text("Scannez-moi !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 20,
                            color: Colors.black)),
                    InkWell(
                      onTap: _scanBarcode,
                      child: const Image(
                        image: AssetImage('assets/code_barre.png'),
                        height: 200,
                        width: 200,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 325,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _goToScannedProductsPage(context),
                    child: const Text(
                      'Voir les produits scannés',
                      style: TextStyle(
                        fontFamily: "RedHatDisplay",
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 375, // position the text under the card
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("STEP BY STEP",
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
                  ],
                ),
              )),
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
