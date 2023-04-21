import 'package:flutter/material.dart';

class RecipeDescriptionPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDescriptionPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(recipe['image']),
            SizedBox(height: 20),
            Text('Temps de réalisation: ${recipe['time']} minutes'),
            SizedBox(height: 20),
            Text('Difficulté: ${recipe['difficulty']}'),
            SizedBox(height: 20),
            Text('Ingrédients:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recipe['ingredients'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: Text(recipe['ingredients'][index]),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Instructions:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recipe['instructions'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(recipe['instructions'][index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
