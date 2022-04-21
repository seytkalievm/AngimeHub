part of 'register_bloc.dart';

class RegisterState{
  final String firstName;
  final String secondName;
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  RegisterState({
    this.firstName = "",
    this.secondName = "",
    this.email = "",
    this.password = "",
    this.formStatus = const InitialFormStatus(),
  });


  RegisterState copyWith({
    String? firstName,
    String? secondName,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }){
    return RegisterState(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus?? this.formStatus,
    );
  }

}
