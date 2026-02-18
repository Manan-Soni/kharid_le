import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../core/enums/user_role.dart';

class AuthProvider extends ChangeNotifier{
  UserModel? _user;
  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  UserRole? get activeRole => _user?.activeRole;

  void login(UserModel user){
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void switchRole(UserRole role){
    if (_user != null && _user!.roles.contains(role)){
      _user!.activeRole = role;
      notifyListeners();
    }
  }
}