import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/navigation/app_navigator.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/navigation/user_bottom_bar/user_bottom_bar_view.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/auth_repository.dart';

void main() {
  runApp(
    MaterialApp(
      theme: CommonStyle.mainTheme(),
      debugShowCheckedModeBanner: false,
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


}
