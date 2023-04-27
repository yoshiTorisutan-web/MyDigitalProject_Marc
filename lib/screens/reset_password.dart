// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class PasswordResetPage extends StatelessWidget {
//   final TextEditingController passwordController = TextEditingController();

//   PasswordResetPage({super.key});

//   void resetPassword(BuildContext context) async {
//     final supabase = Supabase.instance.client;
//     final newPassword = passwordController.text;

//     if (newPassword.isEmpty) {
//       // L'utilisateur n'a pas fourni de nouveau mot de passe
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('Veuillez fournir un nouveau mot de passe.'),
//         ),
//       );
//       return;
//     }

//     final response = await supabase.auth.api.updateUser(password: newPassword);

//     if (response.error != null) {
//       // Une erreur s'est produite lors de la réinitialisation du mot de passe
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('Une erreur s\'est produite. Veuillez réessayer.'),
//         ),
//       );
//     } else {
//       // Le mot de passe a été réinitialisé avec succès
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.green,
//           content: Text('Votre mot de passe a été réinitialisé avec succès.'),
//         ),
//       );
//       // Naviguez vers la page de connexion ou toute autre page appropriée
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Réinitialisation de mot de passe'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(
//                 labelText: 'Nouveau mot de passe',
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () => resetPassword(context),
//               child: const Text('Réinitialiser le mot de passe'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
