import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/screens/shopping_ingredients_recipes.dart';
import 'package:marc_project/widgets/bottom_navbar.dart';
import 'package:marc_project/widgets/search_bar.dart';

import '../constants/constants.dart';

class RecipeDescriptionPage extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const RecipeDescriptionPage({super.key, required this.recipe});

  @override
  State<RecipeDescriptionPage> createState() => _RecipeDescriptionPageState();
}

class _RecipeDescriptionPageState extends State<RecipeDescriptionPage> {
  List<String> selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Text(
                      'Beaucouzé, ANGERS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay",
                          fontSize: 10,
                          color: Constants().textColorOrange),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.expand_more,
                    color: Constants().iconColor,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
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
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartPage(items: [],)),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/caddie.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SearchNavBar(),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RecipePage()));
                  },
                  icon: Icon(Icons.chevron_left,
                      color: Constants().secondaryColor)),
              Text('Revenir à la page précédente',
                  style: TextStyle(
                      fontFamily: "RedHatDisplay",
                      fontSize: 12,
                      color: Constants().secondaryColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.recipe['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "RedHatDisplay",
                        color: Constants().textColor),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // change la position de l'ombre
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.recipe['image']),
                      radius: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${widget.recipe['time']} min | ${widget.recipe['difficulty']}',
                    style: TextStyle(
                        fontFamily: "RedHatDisplay",
                        color: Constants().textColor),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'INGREDIENTS',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                color: Constants().textColor),
                          ),
                        ),
                        Tooltip(
                          message: 'Voir plus',
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.info,
                              color: Constants().textColorBright,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.recipe['ingredients'].length,
                        itemBuilder: (context, index) {
                          String ingredient =
                              widget.recipe['ingredients'][index];
                          return CheckboxListTile(
                            activeColor: Constants().secondaryColor,
                            title: Text(
                              ingredient,
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                color: Constants().textColor,
                              ),
                            ),
                            value: selectedIngredients.contains(ingredient),
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (value) {
                                    selectedIngredients.add(ingredient);
                                  } else {
                                    selectedIngredients.remove(ingredient);
                                  }
                                }
                              });
                            },
                          );
                        },
                      )),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectedIngredientsPage(
                                selectedIngredients: selectedIngredients,
                              ),
                            ),
                          );
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text('Envoyer les ingrédients sélectionnés',
                                style: TextStyle(fontFamily: "RedHatDisplay")),
                            Icon(Icons.send),
                          ],
                        ),
                      )),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Etapes',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay",
                                color: Constants().textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.recipe['instructions'].length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Constants().secondaryColor,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              widget.recipe['instructions'][index],
                              style: TextStyle(
                                  fontFamily: "RedHatDisplay",
                                  color: Constants().textColor),
                            ),
                          );
                        },
                      )),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          )
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
