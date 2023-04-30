
//Données brutes de recettes de cuisine pour le prototype et pour les pages de "Détails de Recettes"
//Je récupère : son nom, le temps de réalisation, la difficulté et les ingrédients pour réaliser la recette
//Et pour finir, les instructions pour la réaliser

List<Map<String, dynamic>> recipeData = [
  {
    'title': 'Salade César',
    'image': 'assets/salade-cesar.jpg',
    'time': 20,
    'difficulty': 'FACILE',
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
    'difficulty': 'MOYENNE',
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
    'difficulty': 'DIFFICILE',
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
