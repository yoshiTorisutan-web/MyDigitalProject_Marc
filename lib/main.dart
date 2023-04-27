import 'package:marc_project/screens/categories_products.dart';
import 'package:marc_project/screens/connexion.dart';
import 'package:marc_project/screens/create_account.dart';
import 'package:marc_project/screens/lost_password.dart';
import 'package:marc_project/screens/recipes.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/screens/scan_info_result.dart';
import 'package:marc_project/screens/time_saved.dart';
import 'package:marc_project/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  Supabase.initialize(
    url: 'https://ejygpysnzakgkwfjgygg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVqeWdweXNuemFrZ2t3ZmpneWdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI1ODkwMzYsImV4cCI6MTk5ODE2NTAzNn0.JyGQf2Ds5vu9esRqybEICaBmv_WU1lxm6iGl94iQ_X4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
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
            )
      },
      initialRoute: '/welcome',
    );
  }
}
