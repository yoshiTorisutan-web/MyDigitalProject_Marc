import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final _formKey = GlobalKey<FormState>();
  String name = "Toto";
  String city = "Angers";
  String mail = 'toto49@gmail.com';
  String password = '1234';
  int _currentIndex = 0;

  final List<Widget> _children = [
    const RecipePage(),
    //SignupPage(),
    //ForgotPasswordPage(),
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Vérifiez ici les informations d'identification de l'utilisateur
      // et connectez-le à l'application si les informations sont valides.
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: _buildRecipeList(_recipes.sublist(0, 5)),
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
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Annuler", true, ScanMode.BARCODE);
          // ignore: avoid_print
          print(barcodeScanRes);
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
