import '../core/enums/user_role.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final List<UserRole> roles;
  UserRole activeRole;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.activeRole,
});
}