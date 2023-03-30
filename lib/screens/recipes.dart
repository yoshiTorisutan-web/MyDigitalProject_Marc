import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<dynamic> _recipes = [];
  bool _isLoading = true;

  final String _apiKey = 'e7d8103d0f674050924ec567074b3e0a';

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    final response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=$_apiKey&addRecipeInformation=true&number=50',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        _recipes = json.decode(response.body)['results'];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recettes'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'À la une',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _recipes.length,
                      itemBuilder: (ctx, index) {
                        final recipe = _recipes[index];

                        if (recipe['image'] == null) {
                          return Container();
                        }

                        return InkWell(
                          onTap: () {
                            //navigate to recipe details page
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipe['image'],
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  recipe['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Entrées',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRecipeList('entrée'),
                  const SizedBox(height: 10),
                  const Text(
                    'Plats',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRecipeList('plat'),
                  const SizedBox(height: 10),
                  const Text(
                    'Desserts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRecipeList('dessert'),
                  const SizedBox(height: 10),
                  const Text(
                    'Petit-Dej',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRecipeList('petit déjeuner'),
                ],
              ),
            ),
    );
  }

  Widget _buildRecipeList(String category) {
    final recipes = _recipes.where((recipe) {
      final title = recipe['title'].toLowerCase();
      return title.contains(category) ||
          title.contains('${category}s') ||
          title.contains('${category}es');
    }).toList();
    if (recipes.isEmpty) {
      return const Center(
        child: Text('Aucune recette trouvée pour cette catégorie'),
      );
    }

    return Column(
      children: recipes.map((recipe) {
        return InkWell(
          onTap: () {
            //navigate to recipe details page
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    recipe['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Temps de préparation : ${recipe['readyInMinutes']} min',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
