import 'dart:convert';
import 'package:http/http.dart' as http;

//Appel de l'API SPOONACULAR avec un flitre des ingrédients pour rechercher les ingrédients 
//via la barre de recherche en haut de certaines pages de l'application

Future<List<String>> fetchIngredients(String query) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/food/ingredients/autocomplete?query=$query&number=15&apiKey=e7d8103d0f674050924ec567074b3e0a'));

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));
    final List<String> ingredients =
        data.map((ingredient) => ingredient['name'].toString()).toList();
    return ingredients;
  } else {
    throw Exception('Failed to load ingredients');
  }
}
