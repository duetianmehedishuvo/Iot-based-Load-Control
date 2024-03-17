import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {

  final bool _isLoading = false;

  bool get isLoading => _isLoading;


  //TODO: for user ROLL:
  List<String> userRollLists = ['Parents','Child','Brother','Other'];
  String selectUserRoll = 'Parents';

  changeUserRoll(String value) {
    selectUserRoll = value;
    notifyListeners();
  }
}
