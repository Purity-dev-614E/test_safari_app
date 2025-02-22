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
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString("user_role");

  String initialRoute = '/login';
  if(role != null){
    if (role == "Admin"){
      initialRoute = "/adminDashboard";
    }else if ( role == "Super Admin"){
      initialRoute = '/super_admin_dashoard';
    }else {
      initialRoute = "/userDashboard";
    }
  }

  await Supabase.initialize(
    url: 'https://twfzhtlkxeicfesrrusi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR3ZnpodGxreGVpY2Zlc3JydXNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk5NjI1NTksImV4cCI6MjA1NTUzODU1OX0.wCJ-eZMRx8-8F4B8J4d7XF00qh1F-2fXlISonkM5UG4'
  );
  runApp( MaterialApp(
      title: 'Church App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
             colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
             useMaterial3: true,
      ),
      initialRoute: initialRoute,
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
        '/Profile' : (context) => UserProfileScreen(),
        '/signup' : (context) => signup()

      },
    )
  );
}

