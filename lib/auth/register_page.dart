
import 'package:angimehub/styles.dart';
import 'package:angimehub/text_form_fields.dart';
import 'package:angimehub/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget{
  const RegisterForm({Key? key}) : super(key: key);

  
  
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
  
}

class RegisterState extends State<RegisterForm>{
  
  final _registerFormKey = GlobalKey<RegisterState>();
  
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
            child: MyTextFormField(
                "First name", NameValidator("Invalid First name")
            ),
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
            child: MyTextFormField(
                "Second Name", NameValidator("Invalid Second name")
            ),
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
            child: MyTextFormField(
                "Enter your e-mail", EmailValidator("Invalid email")
            ),
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
            child: MyTextFormField(
              "Create password",
              passwordValidator,
              isObscure: true,
            ),
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
            child: MyTextFormField(
              "Confirm password",
              NameValidator("Passwords don't match"),
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
                "Register",
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
