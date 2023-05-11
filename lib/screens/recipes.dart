import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/models/details_recipes.dart';
import 'package:marc_project/screens/list_supermarket.dart';
import 'package:marc_project/screens/recipes_details.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/header_cart.dart';
import '../widgets/search_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Page de "Recettes" regroupant tout un choix de recettes que l'utilisateur pourra consulter et réaliser chez lui
//ou tout simplement en cliquant sur une recette avoir plus d'informations et choisir les ingrédients qu'il voudra
//prendre par la suite dans le magasin

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<dynamic> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants().primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Constants().secondaryColor,
                  radius: 30.0,
                  child: SvgPicture.asset(
                    'assets/MAARC.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Où souhaitez-vous faire",
                  style: TextStyle(
                    color: Constants().textColor,
                    fontFamily: "RedHatDisplay",
                    fontSize: 16,
                  ),
                ),
                Text(
                  "vos courses ?",
                  style: TextStyle(
                    color: Constants().textColor,
                    fontFamily: "RedHatDisplay",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  child: ListTile(
                    title: Text(
                      "Mon Magasin",
                      style: TextStyle(
                        color: Constants().textColor,
                        fontFamily: "RedHatDisplay",
                        fontSize: 12,
                      ),
                    ),
                    subtitle: Text(
                      "Super U Beaucouzé, Angers",
                      style: TextStyle(
                        color: Constants().textColorOrange,
                        fontFamily: "RedHatDisplay",
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      "1 km",
                      style: TextStyle(
                        color: Constants().textColor,
                        fontFamily: "RedHatDisplay",
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SupermarketList()));
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
                      Text('Me rendre dans un magasin différent',
                          style: TextStyle(fontFamily: "RedHatDisplay")),
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'accéder au recettes de marc sans me géolocaliser ',
                            style: TextStyle(
                              fontFamily: "RedHatDisplay",
                              fontSize: 10,
                              color: Constants().textColorBright,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.spoonacular.com/recipes/random?number=50&apiKey=e7d8103d0f674050924ec567074b3e0a',
        ),
      );
      final data = json.decode(response.body);
      setState(() {
        _recipes = data['recipes']
            .where(
                (recipe) => recipe['title'] != null && recipe['image'] != null)
            .toList();
        _isLoading = false;
      });
    } catch (error) {
      rethrow;
    }
  }

  Widget _buildRecipeList(List<dynamic> recipes) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:
                          const Offset(0, 3), // change la position de l'ombre
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(recipe['image']),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                recipe['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecipeTestList(List<Map<String, dynamic>> recipes) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDescriptionPage(recipe: recipe),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // change la position de l'ombre
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(recipe['image']),
                    radius: 60,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recipe['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
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
        title: const Header(),
        actions: const <Widget>[HeaderCart()],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SearchNavBar(),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Constants().secondaryColor))
                : ListView(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Recettes à la une       ----------------------------------',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 175,
                        child: _buildRecipeTestList(recipeData),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Entrées      --------------------------------------------',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 175,
                        child: _buildRecipeList(
                          _recipes
                              .where((recipe) =>
                                  recipe['dishTypes'].contains('starter'))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Plats     -----------------------------------------------',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 175,
                        child: _buildRecipeList(
                          _recipes
                              .where((recipe) =>
                                  recipe['dishTypes'].contains('main course'))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Desserts     -------------------------------------------',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 175,
                        child: _buildRecipeList(
                          _recipes
                              .where((recipe) =>
                                  recipe['dishTypes'].contains('dessert'))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Petit-Déjeuner    --------------------------------------',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 175,
                        child: _buildRecipeList(
                          _recipes
                              .where((recipe) =>
                                  recipe['dishTypes'].contains('breakfast'))
                              .toList(),
                        ),
                      ),
                    ],
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
