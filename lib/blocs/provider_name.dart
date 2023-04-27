import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends ChangeNotifier {
  String? userName;

  void setUserName(String? name) {
    userName = name;
    notifyListeners();
  }
}

class UserStateProvider extends StatelessWidget {
  final UserState userState;
  final Widget child;

  const UserStateProvider({super.key, 
    required this.userState,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userState,
      child: child,
    );
  }
}
