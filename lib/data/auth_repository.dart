import 'dart:convert';

import 'package:http/http.dart' as http;


const apiBase = 'http://35.246.32.45:80/';



class AuthRepository{

  Future<String> attemptAutoLogin() async {
    await Future.delayed(const Duration(seconds: 1  ));
    throw Exception('not signed in');
  }

  Future<int> login(
      String email,
      String password) async{
    int statusCode;
    try {
      final response = await http.get(
        Uri.parse(apiBase+"user/login?email=$email&password=$password"),
          headers: <String, String>{
          'Content-Type': 'application/json',
            'Charset': 'utf-8',
          },
      );
      statusCode = response.statusCode;
    }catch (e){
      statusCode = -1;
    }
    return statusCode;
  }

  Future<int> register(
      String firstName,
      String secondName,
      String email,
      String password) async{
    int statusCode;
    try {
      final response = await http.post(
        Uri.parse(apiBase + "user/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'secondName': secondName,
          'email': email,
          'password': password
        }),
      );
      statusCode = response.statusCode;
    }catch (e){
      statusCode = -1;
    }
    
    return statusCode;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}