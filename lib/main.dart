import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/navigation/app_navigator.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/auth_repository.dart';

void main() {
  runApp(
    MaterialAp(
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
