import 'dart:convert';

import 'package:angime_hub/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../styles.dart';

loginUser({
  required String email,
  required String password,
}) async {
  final responce = await http.get(
    Uri.parse(
        'http://192.168.0.106:8080/user/login?email=$email&password=$password'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    },
  );
  if (responce.statusCode != 200) {
    print(jsonDecode(responce.body)['message']);
  } else {
    print(responce.statusCode);
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();

  late String email;
  late String password;

  Widget _emailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "E-mail"),
      cursorColor: Colors.white,
      validator: emailValidator,
      onSaved: (value) {
        email = value!.toString();
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "Password"),
      cursorColor: Colors.white,
      validator: passwordValidator,
      onSaved: (value) {
        password = value!.toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Welcome Back!",
                style: CommonStyle.headingTextStyle(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
            child: Text(
              "E-mail",
              style: CommonStyle.descriptionTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: _emailTextField(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
            child: Text(
              "Password",
              style: CommonStyle.descriptionTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: _passwordTextField(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 11, 191, 184)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text(
                "Log in",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Open Sans",
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (!_loginFormKey.currentState!.validate()) {
                  return;
                }
                _loginFormKey.currentState?.save();
                loginUser(email: email, password: password);
              },
            ),
          ),
        ],
      ),
    );
  }
}
