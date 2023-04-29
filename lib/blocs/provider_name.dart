import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends ChangeNotifier {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  void setUserLoggedIn(bool value) {
    _isUserLoggedIn = value;
    notifyListeners();
  }

  String? userName;
  String? userLastname;
  String? userPhone;
  String? userBirthday;
  String? userEmail;
  String? userCard;
  String? userExpirationDate;
  String? userCVC;

  void setUserName(
      String? name,
      String? lastname,
      String? phone,
      String? birthday,
      String? email,
      String? card,
      String? expirationDate,
      String? cvc) {
    userName = name;
    userLastname = lastname;
    userPhone = phone;
    userBirthday = birthday;
    userEmail = email;
    userCard = card;
    userExpirationDate = expirationDate;
    userCVC = cvc;
    notifyListeners();
  }
}

class UserStateProvider extends StatelessWidget {
  final UserState userState;
  final Widget child;

  const UserStateProvider({
    super.key,
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
