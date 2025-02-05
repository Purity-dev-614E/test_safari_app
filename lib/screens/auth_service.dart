import 'package:church_app/users.dart';
import 'package:church_app/permissions.dart';

Future<User?> authenticateUser(String email, String password)async {
  await Future.delayed(Duration(seconds: 2));


  if (email == "superadmin@gmail.com" && password == "password") {
    return User(
        id: '1',
        email: email,
        role: UserRole.superAdmin);
  } else if (email == "admin@gmail.com" && password == "password") {
    return User(
        id: '2',
        email: email,
        role: UserRole.admin);
  } else if (email.endsWith("@gmail.com") && password == "password") {
    return User(
        id: '3',
        email: email,
        role: UserRole.normalUser
    );
  } else {
    return null;
  }
}

