import 'dart:convert';
import 'dart:io';

import 'package:angime_hub/styles.dart';
import 'package:angime_hub/text_form_fields.dart';
import 'package:angime_hub/validators.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

registerUser({
  required String firstname,
  required String secondname,
  required String email,
  required String password,
}) async {
  final responce = await http.post(
    Uri.parse('http://192.168.0.106:8080/user/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstname,
      'secondName': secondname,
      'email': email,
      'password': password
    }),
  );
  print(responce.statusCode);
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();

  late String firstName;
  late String secondName;
  late String email;
  late String password;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  Widget _firsNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "First name"),
      cursorColor: Colors.white,
      validator: firstNameValidator,
      onSaved: (value) {
        firstName = value!.toString();
      },
    );
  }

  Widget _secondNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "Second name"),
      cursorColor: Colors.white,
      validator: secondNameValidator,
      onSaved: (value) {
        secondName = value!.toString();
      },
    );
  }

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
      controller: passwordController,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "Password"),
      cursorColor: Colors.white,
      validator: passwordValidator,
    );
  }

  Widget _confPasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: confPasswordController,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "Confirm password"),
      cursorColor: Colors.white,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Confirm password";
        } else if (confPasswordController.text != passwordController.text) {
          return "Passwords don't match";
        }
        return null;
      },
      onSaved: (value) {
        password = confPasswordController.text;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Register",
                style: CommonStyle.headingTextStyle(),
              ),
            ),
          ),

          //First Name
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
            child: Text(
              "First name",
              style: CommonStyle.descriptionTextStyle(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: _firsNameTextField(),
          ),

          // Second Name
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
            child: Text(
              "Second name",
              style: CommonStyle.descriptionTextStyle(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: _secondNameTextField(),
          ),

          // E-mail
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
            child: Text(
              "E-mail",
              style: CommonStyle.descriptionTextStyle(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: _emailTextField(),
          ),

          // Password
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

          // Confirm password
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
            child: Text(
              "Confirm password",
              style: CommonStyle.descriptionTextStyle(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: _confPasswordTextField(),
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
                "Register",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Open Sans",
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (!_registerFormKey.currentState!.validate()) {
                  return;
                }
                _registerFormKey.currentState!.save();
                registerUser(
                    firstname: firstName,
                    secondname: secondName,
                    email: email,
                    password: password);
              },
            ),
          ),
        ],
      ),
    );
  }
}
