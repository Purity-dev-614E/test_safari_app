import 'package:church_app/screens/GroupAnalytics.dart';
import 'package:church_app/screens/GroupMembers.dart';
import 'package:church_app/screens/Profile.dart';
import 'package:church_app/screens/SuperAnalytics.dart';
import 'package:church_app/screens/SuperSettings.dart';
import 'package:church_app/screens/UserManagement.dart';
import 'package:church_app/screens/adminDashboard.dart';
import 'package:church_app/screens/super_admin_dashoard.dart';
import 'package:church_app/screens/userDashboard.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Church App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
             colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
             useMaterial3: true,
      ),
      initialRoute: '/login',
      routes:{
        '/login': (context) => login(),
        '/super_admin_dashoard': (context) => SuperAdminDashoard(),
        '/adminDashboard' : (context) => adminDashboard(),
        '/UserManagement' : (context) => Usermanagement(),
        '/SuperAnalytics' : (context) => Superanalytics(),
        '/SuperSettings' : (context) => Supersettings(),
        '/GroupMembers' : (context) => Groupmembers(),
        '/GroupAnalytics' : (context) => Groupanalytics(),
        '/userDashboard' : (context) => userDashboard(),
        '/Profile' : (context) => UserProfileScreen()

      },
    );
  }
}

