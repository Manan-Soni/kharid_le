import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../core/enums/user_role.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  UserModel? _user;
  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  UserRole? get activeRole => _user?.activeRole;

  final AuthService _authService = AuthService();

  void login(UserModel user){
    _user = user;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
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