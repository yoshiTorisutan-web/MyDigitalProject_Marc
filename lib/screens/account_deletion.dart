import 'package:marc_project/blocs/provider_name.dart';
import 'package:marc_project/screens/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'connexion.dart';

//Page de "Suppression de compte" où l'utilisateur pourra avoir la possibilité de supprimer son compte
//s'il veut quitter et ne plus utiliser l'application

class AccountDeletion extends StatefulWidget {
  const AccountDeletion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountDeletionState createState() => _AccountDeletionState();
}

class _AccountDeletionState extends State<AccountDeletion> {
  //Fonction qui permet de supprimer le compte sur l'application et dans la BDD Supabase
  Future<void> deleteAccount(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final userState = context.read<UserState>();

    if (userState.isUserLoggedIn) {
      final loggedInUserEmail = userState.userEmail;

      supabase
          .from('user')
          .delete()
          .eq('email', loggedInUserEmail)
          .execute()
          .then((response) {
        // Vérifier la réponse de suppression
        if (response.error != null) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 255, 8, 8),
            content: Text('Erreur, le compte n\'a pas pu être supprimé ! ❌'),
          ));
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 0, 87, 19),
            content: Text('Compte supprimé avec succès ✅'),
          ));
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 8, 8),
        content: Text('Erreur, vous n\'êtes pas connecté ! ❌'),
      ));
    }
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
      body: Stack(
        children: [
          Positioned(
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AppSetting()));
                              },
                              icon: const Icon(Icons.chevron_left)),
                          const Text(
                            'Paramètre de l\'application',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "RedHatDisplay"),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Suppression du compte',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "RedHatDisplay"),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView(
                          padding: const EdgeInsets.only(top: 10),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const ListTile(
                              title: Text(
                                  "Vous souhaitez vraiment supprimer votre compte ?",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RedHatDisplay")),
                              subtitle: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut accumsan ligula sed felis faucibus aliquet.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RedHatDisplay")),
                            ),
                          ],
                        )),
                    const SizedBox(height: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            deleteAccount(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text('Supprimer mon compte',
                                  style:
                                      TextStyle(fontFamily: "RedHatDisplay")),
                              Icon(Icons.cancel),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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
