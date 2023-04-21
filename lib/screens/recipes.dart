import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/recipes_details.dart';
import 'package:marc_project/screens/scan_info.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';

  List<dynamic> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
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
              CircleAvatar(
                backgroundImage: NetworkImage(recipe['image']),
                radius: 60,
              ),
              const SizedBox(height: 10),
              Text(
                recipe['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 8),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> recipeData = [
    {
      'title': 'Salade César',
      'image': 'assets/salade-cesar.jpg',
      'time': 20,
      'difficulty': 'Facile',
      'ingredients': [
        'Laitue romaine',
        'Poulet grillé',
        'Parmesan',
        'Croûtons',
        'Sauce César',
      ],
      'instructions': [
        'Laver et sécher la laitue romaine',
        'Griller le poulet et le couper en tranches',
        'Râper le parmesan',
        'Faire des croûtons',
        'Assembler la salade avec tous les ingrédients et la sauce César',
      ],
    },
    {
      'title': 'Pizza Margherita',
      'image': 'assets/pizza-margherita.jpg',
      'time': 30,
      'difficulty': 'Moyenne',
      'ingredients': [
        'Pâte à pizza',
        'Sauce tomate',
        'Mozzarella',
        'Tomates',
        'Basilic',
      ],
      'instructions': [
        'Préchauffer le four à 200°C',
        'Abaisser la pâte à pizza',
        'Étaler la sauce tomate sur la pâte',
        'Ajouter la mozzarella, les tomates et le basilic',
        'Cuire au four pendant 20 minutes',
      ],
    },
    {
      'title': 'Pâtes à la bolognaise',
      'image': 'assets/pate-bolognaise.jpg',
      'time': 45,
      'difficulty': 'Difficile',
      'ingredients': [
        'Pâtes',
        'Viande hachée',
        'Oignon',
        'Ail',
        'Tomates',
        'Concentré de tomates',
        'Basilic',
        'Huile d\'olive',
        'Sel',
        'Poivre',
      ],
      'instructions': [
        'Faire cuire les pâtes selon les instructions sur l\'emballage',
        'Faire revenir l\'oignon et l\'ail dans de l\'huile d\'olive',
        'Ajouter la viande hachée et faire cuire jusqu\'à ce qu\'elle soit dorée',
        'Ajouter les tomates, le concentré de tomates, le basilic, le sel et le poivre',
        'Laisser mijoter la sauce pendant 20 minutes',
        'Servir la sauce sur les pâtes cuites',
      ],
    },
  ];

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
                CircleAvatar(
                  backgroundImage: AssetImage(recipe['image']),
                  radius: 60,
                ),
                const SizedBox(height: 10),
                Text(
                  recipe['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 8),
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
                          'Plats     ----------------------------------------------',
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
