import 'package:angime_hub/ui/auth/auth_credentials.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(LogIn());

  void showLogIn() => emit (LogIn());
  void showRegister() => emit(Register());
  Future<void> launchSession() {
    return sessionCubit.showSession();
  }

}
