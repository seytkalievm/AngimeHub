import 'package:angime_hub/ui/auth/auth_credentials.dart';
import 'package:bloc/bloc.dart';

import '../../data/database/user/user_database.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final db = UserDatabase.instance;

  SessionCubit({required this.authRepo}) : super(UnknownSessionState()){
      attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final user = await authRepo.attemptAutoLogin();
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }
  void shouAuth() => emit(Unauthenticated());

  Future<void> showSession() async {
    final user = await db.getUser();
    emit(Authenticated(user: user));
  }

  void signOut(){
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
