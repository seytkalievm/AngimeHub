import 'dart:convert';
import 'package:angime_hub/data/database/user/user_database.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

const apiBase = 'http://35.246.32.45:80/';

class AuthRepository{

  late String userToken;
  final db = UserDatabase.instance;

  Future<User> attemptAutoLogin() async {
    late User user;
    try{
      user = await db.getUser();
      return user;
    }catch (e){
      rethrow;
    }
  }

  Future<int> login(
      String email,
      String password) async{
    int statusCode;
    User user;
    try {
      final response = await http.get(
        Uri.parse(apiBase+"user/login?email=$email&password=$password"),
          headers: <String, String>{
          'Content-Type': 'application/json',
            'Charset': 'utf-8',
          },
      );
      statusCode = response.statusCode;
      if(statusCode == 200){
        print("logged in");
      }
      userToken = response.body;
      print("token: $userToken");
      user = await getUser();
      db.addUser(user);
    }catch (e){
      print(e.toString());
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

  Future <User> getUser() async{
    final response = await http.get(
      Uri.parse(apiBase + 'user/info?token=$userToken'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
      },
    );
    var firstName = jsonDecode(response.body)["firstName"].toString();
    var secondName = jsonDecode(response.body)["secondName"].toString();
    var email = jsonDecode(response.body)["email"].toString();
    var user = User(firstName: firstName, secondName: secondName, email: email);
    await db.addUser(user);
    return user;
  }

  Future<int> signOut() async {
    print("signing out @auth_repository");
    return await db.deleteUser();
  }
}