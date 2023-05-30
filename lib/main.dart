import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/screens/categories_products.dart';
import 'package:marc_project/screens/connexion.dart';
import 'package:marc_project/screens/create_account.dart';
import 'package:marc_project/screens/lost_password.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/screens/scan_info_result.dart';
import 'package:marc_project/screens/shopping_ingredients_recipes.dart';
import 'package:marc_project/screens/time_saved.dart';
import 'package:marc_project/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//Lancement de l'applicaton et gestion du provider

void main() {
  //Clé Supabase
  Supabase.initialize(
    url: 'https://ejygpysnzakgkwfjgygg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVqeWdweXNuemFrZ2t3ZmpneWdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI1ODkwMzYsImV4cCI6MTk5ODE2NTAzNn0.JyGQf2Ds5vu9esRqybEICaBmv_WU1lxm6iGl94iQ_X4',
  );

  //Clé Stripe
  WidgetsFlutterBinding.ensureInitialized();
    
  // définit la clé publiable pour Stripe
  Stripe.publishableKey = 'pk_test_51N0jv7GJjR7vmavNnzT4Mqt3jBINr6abZN7c84KPTvfdwTHTLlYfZabWo0pRoBMXXjsuvVikWWT4XivEzSxFb07b00Lt5vs4uu';

  runApp(
    UserStateProvider(
      userState: UserState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // définit les routes principales de l'application et package provider qui 
  // facilite la communication et la gestion des données partagées entre les widgets de votre application. 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
        create: (_) => UserState(),
        child: MaterialApp(
          title: 'A VOS MARC, PAYEZ, PARTEZ !',
          debugShowCheckedModeBanner: false,
          routes: {
            '/login': (context) => const LoginPage(),
            '/lostpassword': (context) => const LostPassword(),
            '/welcome': (context) => const Welcome(),
            '/createAccount': (context) => const CreateAccount(),
            '/recipes': (context) => const RecipePage(),
            '/account': (context) => const TimeSaved(),
            '/categoriesProducts': (context) => CategoryListPage(),
            '/scan': (context) => const ScanInfo(),
            '/productList': (context) => const ScanInfoResult(
                  scannedProducts: [],
                ),
            '/mylist': (context) => const SelectedIngredientsPage(
                  selectedIngredients: [],
                )
          },
          initialRoute: '/welcome',
        ));
  }
}
