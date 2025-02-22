import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_services.dart';

class ApiService{
  final String baseUrl = 'http://localhost:500/api';

  //fetch members
  Future<List<dynamic>> fetchMembers() async{
    String? token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/members"),
      headers: {
        "Content-type" : "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      throw Exception('Failed to load members');
    }
  }
}