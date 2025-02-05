import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:church_app/users.dart';
import 'package:church_app/permissions.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  //simulating backendAuthentication

  void _login() async  {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await authenticateUser(email, password);
    if (user != null) {
      // Role-based landing page logic:
      if (user.role == UserRole.superAdmin) {
        Navigator.pushReplacementNamed(context, '/super_admin_dashoard');
      } else if (user.role == UserRole.admin) {
        Navigator.pushReplacementNamed(context, '/adminDashboard'
        );
      } else if (user.role == UserRole.normalUser) {
    Navigator.pushReplacementNamed(context,  '/userDashboard');

      }
    } else {
      // Show an error message if login fails.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials. Please try again.")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to Church',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 2.5,
                  ),

                ),
              ),
              SizedBox(height: 100.0,),

              Text(
                  'Full Name',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.blue,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 20.0,),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Email Address'
                ),
              ),

              SizedBox(height: 30.0,),

              Text(
                'Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.blue,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 20.0,),

              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              SizedBox(height: 40.0,),

              isLoading
              ?Center(child: CircularProgressIndicator(
                color: Colors.blue,
              )):
              Center(
                child: TextButton(
                    onPressed: _login,
                    child: Text(
                        'LOGIN',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.5
                      ),
                    )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
