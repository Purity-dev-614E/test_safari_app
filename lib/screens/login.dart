import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:church_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse("https://test-safari-backend.onrender.com/api/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      }),
    );

    setState(() {
      isLoading = false;
    });

    final data = jsonDecode(response.body);
    print('API Response: $data'); // Debugging

    if (response.statusCode == 200 && data is Map<String, dynamic>) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ensure role exists and normalize it
      String role = data.containsKey("role") && data['role'] != null
          ? data['role'].toString().trim().toLowerCase()
          : 'user'; // Default to 'user' if role is missing

      print('Extracted role: $role'); // Debugging

      await prefs.setString('auth_token', data['token']);
      await prefs.setString('user_role', role); // FIXED - Now role is always a String

      // Navigate based on role
      if (role == "admin") {
        Navigator.pushReplacementNamed(context, "/adminDashboard");
      } else if (role == "super admin") {
        Navigator.pushReplacementNamed(context, "/super_admin_dashoard"); // Fix typo
      } else {
        Navigator.pushReplacementNamed(context, "/userDashboard");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Login failed"))
      );
    }
  }

  void _showCompleteProfileDialog(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('complete profile'),
              content: Text('Your profile is not quite complete, please update the details to continue'),
              actions: [
                TextButton(
                    onPressed: (){

                    },
                    child: Text('Complete Now'),
                )
              ],
            ),
          );
        }
        );

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
                  'Email Address',
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
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/signup');
                  },
                  child:Text('No account? Sign Up'))

            ],
          ),
        ),
      ),
    );
  }
}

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _selectedRole;
  bool isLoading = false;

  final List<String> UserRoles = [ 'admin', 'super admin', 'user'];

  Future<void> _signUp() async{
    if(_selectedRole == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Select a Role")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response =  await http.post(
      Uri.parse(
        "https://test-safari-backend.onrender.com/api/auth/register"
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "role": _selectedRole
      })
    );

    setState(() {
      isLoading  = false;
    });

    final data = jsonDecode(response.body);
    if(response.statusCode == 201){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful, Please log in'))
      );
      Navigator.pop(context);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Church',
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 2.5,
                ),

              ),
              SizedBox(height: 50.0,),


              // Text(
              //   'Enter email Address',
              //   style: TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.w100,
              //     color: Colors.blue,
              //     letterSpacing: 1.5,
              //   ),
              // ),
              // SizedBox(height: 20.0,),

              SizedBox(
                height: 60,
                width: 360,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Your Email Address'
                  ),
                ),
              ),

              // SizedBox(height: 20.0,),

              // Text(
              //   'Enter User name',
              //   style: TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.w100,
              //     color: Colors.blue,
              //     letterSpacing: 1.5,
              //   ),
              // ),
              SizedBox(height: 20.0,),

              SizedBox(
                height: 60,
                width: 360,
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Your Username'
                  ),
                ),
              ),

              // SizedBox(height: 30.0,),


              // Text(
              //   'Password',
              //   style: TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.w100,
              //     color: Colors.blue,
              //     letterSpacing: 1.5,
              //   ),
              // ),
              SizedBox(height: 20.0,),

              SizedBox(
                height: 60,
                width: 360,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 40.0,),

              DropdownButton<String>(
                value: _selectedRole,
                hint: Text("Select Role"),
                items: UserRoles.map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedRole = value);
                },
              ),

              isLoading
                  ?Center(child: CircularProgressIndicator(
                color: Colors.blue,
              )):
              Center(
                child: TextButton(
                    onPressed: _signUp,
                    child: Text(
                      'Sign Up',
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


