import 'dart:convert';

import 'package:angime_hub/ui/main/profile/profile_view.dart';
import 'package:angime_hub/ui/navigation/app_navigator.dart';
import 'package:angime_hub/data/database/user/user_database.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/navigation/user_bottom_bar/user_bottom_bar_view.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:angime_hub/content/globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/repository/auth_repository.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 22, 38),
        fontFamily: "Open Sans",
      ),
      home: Scaffold(
        body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => AuthRepository()),
            RepositoryProvider(create: (context) => DataRepository())
          ],
          child: BlocProvider(
            create: (context) => SessionCubit(
              authRepo: context.read<AuthRepository>(),
              dataRepo: context.read<DataRepository>(),
            ),
            child: const AppNavigator(),
          ),
        ),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  int registered = 0;
  @override
  Widget build(BuildContext context) {
    return getScreen();
  }

  Widget getScreen() {
    if (registered == 0) {
      return UserBottomBar();
    } else {
      getProfileInfo();
      return UserBottomBar();
    }
  }

  void changePage() {
    setState(() {
      if (registered == 0) {
        registered = 1;
      } else {
        registered = 0;
      }
    });
  }

  void getProfileInfo() async {
    // ignore: non_constant_identifier_names
    String IP = globals.IP;
    String token = globals.token;
    final response = await http.get(
      Uri.parse('http://$IP:8080/user/info?token=$token'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
      },
    );
    globals.firstname = jsonDecode(response.body)["firstName"].toString();
    globals.secondname = jsonDecode(response.body)["secondName"].toString();
    globals.email = jsonDecode(response.body)["email"].toString();
  }
}
