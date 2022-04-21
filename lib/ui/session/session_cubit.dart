
import 'package:angime_hub/data/auth_repository.dart';
import 'package:angime_hub/ui/auth/auth_credentials.dart';
import 'package:bloc/bloc.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({required this.authRepo}) : super(UnknownSessionState()){
      attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      final user = userId;
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }
  void shouAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials){
    final user = credentials.email;
    emit(Authenticated(user: user));
  }

  void signOut(){
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
