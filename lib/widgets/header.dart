import 'package:flutter/material.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/screens/list_supermarket.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';

//Widget de l'appbar avec le titre et sous titre présent sur les pages principales de l'application et appeler la classe
//Header sur les pages où je veux les afficher

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: Transform.scale(
            scale: 1.2,
            child: Consumer<UserState>(
              builder: (context, userState, _) {
                final userName = userState.userName;
                return RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Bonjour $userName',
                        style: TextStyle(
                          color: Constants().secondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(color: Constants().textColorOrange),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 21.0),
              child: Transform.scale(
                scale: 1.2,
                child: InkWell(
                  child: Text(
                    'Beaucouzé, ANGERS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "RedHatDisplay",
                        fontSize: 10,
                        color: Constants().textColorBright),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SupermarketList()),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.expand_more,
                color: Constants().textColorBright,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
