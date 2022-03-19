

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
      return LoginState();
  }

}

class LoginState extends State<LoginForm>{

  final _loginFormKey = GlobalKey<LoginState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Welcome Back!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 5),
            child: Text(
              "E-mail",
              style: TextStyle(
                  fontFamily: "Open Sans",
                  color: Color.fromARGB(255,133, 135, 159)
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: TextFormField(
              style: const TextStyle(
                fontFamily: "Open Sans",
                color: Colors.white,
              ),
              decoration: CommonStyle.textFieldStyle(hintTextStr: "Enter your e-mail"),
              cursorColor: Colors.white,
              validator: (value){
                if (value == null || value.isEmpty || !value.contains("@")){
                  return "Invalid Email";
                }
                return null;
                },
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Text(
              "Password",
              style: TextStyle(
                  fontFamily: "Open Sans",
                  color: Color.fromARGB(255,133, 135, 159)
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: TextFormField(
              style: const TextStyle(
                fontFamily: "Open Sans",
                color: Colors.white,
              ),
              obscureText: true,
              decoration: CommonStyle.textFieldStyle(hintTextStr: "Password"),
              cursorColor: Colors.white,
              validator: (value){
                if (value == null || value.isEmpty){
                  return "Invalid Password";
                }
                return null;
                },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: ElevatedButton(
              onPressed: () {  },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 11, 191, 184)),
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
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonStyle{
  static InputDecoration textFieldStyle({String labelTextStr="",String hintTextStr=""}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      fillColor: const Color.fromARGB(255, 42, 45, 71),
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      hintText: hintTextStr,
      hintStyle: const TextStyle(
          fontFamily: "Open Sans",
          color: Color.fromARGB(255, 133, 135, 159)
      ),
    );
  }

}

