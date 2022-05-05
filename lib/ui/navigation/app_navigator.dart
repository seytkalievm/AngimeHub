import 'package:angime_hub/ui/auth/auth_cubit.dart';
import 'package:angime_hub/ui/auth/auth_navigator.dart';
import 'package:angime_hub/ui/navigation/user_bottom_bar/user_bottom_bar_view.dart';
import 'package:angime_hub/ui/session/loading_view.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget{
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <SessionCubit, SessionState>(builder: (context, state){
      return Navigator(
      pages: [
          if (state is UnknownSessionState)
            const MaterialPage(child: LoadingView()),

          if (state is Unauthenticated) 
            MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: const AuthNavigator(),
                )
            ),
          if (state is Authenticated)
            MaterialPage(
              child: UserBottomBar(),
            ),
        ],
      );
    }
    );
  }

}