import 'dart:async';
import 'dart:convert';

import 'package:angime_hub/ui/auth/auth_cubit.dart';
import 'package:angime_hub/ui/auth/form_submission_status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/exceptions.dart';
import '../../../data/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthRepository authRepo;
  final AuthCubit authCubit;

  RegisterBloc({
    required this.authRepo,
    required this.authCubit
  }) : super(RegisterState()) {

    on<RegisterFirstNameChanged>(_onRegisterFirstNameChanged);
    on<RegisterSecondNameChanged>(_onRegisterSecondNameChanged);
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);

  }
  void _onRegisterFirstNameChanged(RegisterFirstNameChanged event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onRegisterSecondNameChanged(RegisterSecondNameChanged event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(secondName: event.secondName));
  }

  void _onRegisterEmailChanged(RegisterEmailChanged event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(email: event.email));
  }

  void _onRegisterPasswordChanged(RegisterPasswordChanged event,
      Emitter<RegisterState> emit,){
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event,
      Emitter<RegisterState> emit,) async {
    var firstName = state.firstName;
    var secondName = state.secondName;
    var email = state.email;
    var password = state.password;
    var statusCode = -1;
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      print("$firstName, $secondName, $email. @registerBloc");
      statusCode = await authRepo.register(firstName, secondName, email, password);

      if(statusCode == 200){
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        authCubit.showLogIn();

      }else{
        emit(state.copyWith(formStatus: SubmissionFailed(exception: UserAlreadyExists())));
      }
    }catch (e){
      emit(state.copyWith(formStatus: SubmissionFailed( exception: e as Exception)));
    }


  }


}
