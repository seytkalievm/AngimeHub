import 'package:angimehub/auth/register_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class Authorization extends StatelessWidget{
  const Authorization({Key? key}) : super(key: key);

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
              children: const [
                LoginForm(),

              ],
            ),
          ),
        ),
      )
    );
  }


}