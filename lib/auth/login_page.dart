import 'package:angime_hub/content/globals.dart' as globals;
import 'package:angime_hub/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../styles.dart';

class LoginForm extends StatefulWidget {
  final Function() notifyParent;
  const LoginForm({required this.notifyParent, Key? key}) : super(key: key);

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
                onPressed: () async {
                  if (!_loginFormKey.currentState!.validate()) {
                    return;
                  }
                  _loginFormKey.currentState?.save();

                  // ignore: non_constant_identifier_names
                  String IP = globals.IP;
                  final responce = await http.get(
                    Uri.parse(
                        'http://$IP:8080/user/login?email=$email&password=$password'),
                    headers: <String, String>{
                      'Content-Type': 'application/json',
                      'Charset': 'utf-8',
                    },
                  );
                  if (responce.statusCode == 200) {
                    globals.logged = 1;
                    globals.token = responce.body;
                    widget.notifyParent();
                  } else {
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return InkWell(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: const Center(
                                    child: Text(
                                  "Email or password is incorrect",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
