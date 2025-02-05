import 'package:church_app/permissions.dart';

class User{
  final String id;
  final String email;
  final UserRole role;

  User({required this.id,required this.email,required this.role});
}