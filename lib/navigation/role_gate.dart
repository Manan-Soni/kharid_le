import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import 'seller_navigation.dart';
import 'buyer_navigation.dart';
import '../core/enums/user_role.dart';

class RoleGate extends StatelessWidget{
  const RoleGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (!authProvider.isLoggedIn) {
      return const LoginScreen();
    }

    if (authProvider.activeRole == UserRole.seller) {
      return const SellerNavigation();
    }

    return const BuyerNavigation();
  }
}