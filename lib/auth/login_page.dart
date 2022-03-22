import 'package:angime_hub/validators.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

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

  Widget _emailTextField(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "E-mail"),
      cursorColor: Colors.white,
      validator: emailValidator,
      onSaved: (value){
        email = value!.toString();
      },
    );
  }

  Widget _passwordTextField(){
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: "Password"),
      cursorColor: Colors.white,
      validator: passwordValidator,
      onSaved: (value){
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
                if (!_loginFormKey.currentState!.validate()){
                  return;
                }
                _loginFormKey.currentState?.save();

              },
            ),
          ),
        ],
      ),
    );
  }
}
