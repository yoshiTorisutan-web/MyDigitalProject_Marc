import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marc_project/screens/cart.dart';

class HeaderCart extends StatefulWidget {
  const HeaderCart({Key? key}) : super(key: key);

  @override
  State<HeaderCart> createState() => _HeaderCartState();
}

class _HeaderCartState extends State<HeaderCart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  MaterialPageRoute(
                      builder: (context) => const CartPage(
                            items: [],
                          )),
                );
              },
              child: SvgPicture.asset(
                'assets/caddie.svg',
                width: 24,
                height: 24,
              ),
            )),
      ),
    );
  }
}
