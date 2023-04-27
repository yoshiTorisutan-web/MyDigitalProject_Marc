import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/bottom_navbar.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import '../constants/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;

  const ProductDetailsScreen({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

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
        actions: const <Widget>[
          HeaderCart()
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
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
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
                        Text("CATEGORIE",
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
                        Text(title,
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
                        Text("2.99 €",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 16,
                                color: Constants().secondaryColor)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 12,
                                color: Constants().secondaryColor)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "« Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                fontSize: 12,
                                color: Constants().secondaryColor)),
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
