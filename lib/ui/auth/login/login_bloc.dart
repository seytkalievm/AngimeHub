import 'package:angime_hub/ui/auth/auth_credentials.dart';
import 'package:angime_hub/ui/auth/auth_cubit.dart';
import 'package:angime_hub/ui/auth/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/exceptions.dart';
import '../../../data/repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({
    required this.authRepo,
    required this.authCubit,
  }):super(LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }


  void _onLoginEmailChanged(
      LoginEmailChanged event,
      Emitter<LoginState> emit,
      ){
    emit(state.copyWith(email: event.email));
  }
  void _onLoginPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter <LoginState> emit,
      ) async {

    var email = state.email;
    var password = state.password;


    emit(state.copyWith(formStatus: FormSubmitting()));
    try{
      final statusCode = await authRepo.login(email, password);
      if(statusCode == 200){
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        authCubit.launchSession();
      }else{
        emit(state.copyWith(formStatus: SubmissionFailed(exception: IncorrectCredentials())));
      }
    }catch (e){
      emit(state.copyWith(formStatus: SubmissionFailed( exception: e as Exception)));

    }
  }


}
