import 'package:angime_hub/auth/register_page.dart';
import 'package:angime_hub/styles.dart';
import 'package:flutter/material.dart';

import '../validators.dart';
import 'login_page.dart';

class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AuthorizationState();
  }
}

class AuthorizationState extends State<Authorization> {
  int page = 0;
  String sign = "Sign in";
  String account = "Already have an account?";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 22, 38),
        fontFamily: "Open Sans",
      ),
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getBody(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        account,
                        style: CommonStyle.descriptionTextStyle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: InkWell(
                          child: Text(
                            sign,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 11, 191, 184),
                            ),
                          ),
                          onTap: () {
                            changePage();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (page == 0) {
      return const LoginForm();
    } else {
      return const RegisterForm();
    }
  }

  void changePage() {
    setState(() {
      if (page == 0) {
        page = 1;
        sign = "Sign in";
        account = "Already have an account?";
      } else {
        page = 0;
        sign = "Sign Up";
        account = "Don't have an account?";
      }
    });
  }
}
