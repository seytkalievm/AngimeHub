import 'package:angime_hub/ui/auth/auth_cubit.dart';
import 'package:angime_hub/ui/auth/login/login_view.dart';
import 'package:angime_hub/ui/auth/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget{
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      return Navigator(
        pages: [
          if (state is LogIn) MaterialPage(child: LoginView()),
          if (state is Register) MaterialPage(child: RegisterView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    }
    );
  }

}