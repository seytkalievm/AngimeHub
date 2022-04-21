import 'package:angime_hub/ui/auth/auth_cubit.dart';
import 'package:angime_hub/ui/auth/auth_navigator.dart';
import 'package:angime_hub/ui/session/loading_view.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'content/user_bottom.dart';

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
            const MaterialPage(
                child: UserBottom(),
            ),
        ],
        onPopPage: (route, result){
          return route.didPop(result);
        },
      );
    }
    );
  }

}