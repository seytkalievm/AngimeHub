import 'package:angimehub/text_form_fields.dart';
import 'package:angimehub/validators.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

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
            child: MyTextFormField(
              "E=mail",
              EmailValidator("Invalid e-mail"),
            ),
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
            child: MyTextFormField(
              "Password",
              passwordValidator,
              isObscure: true,
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
                  fontFamily: "Open Sans",
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


