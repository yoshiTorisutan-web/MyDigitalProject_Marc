import 'package:Marc_project/screens/connexion.dart';
import 'package:Marc_project/screens/lost_password.dart';
import 'package:Marc_project/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
        '/welcome': (context) => const Welcome()
      },
      initialRoute: '/welcome',
    );
  }
}
