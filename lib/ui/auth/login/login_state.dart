import 'package:angime_hub/ui/auth/form_submission_status.dart';

class LoginState{
  late String email;
  late String password;
  late FormSubmissionStatus formStatus;

  LoginState({
    this.password = '',
    this.email = '',
    this.formStatus = const InitialFormStatus()
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }){
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus?? this.formStatus,
    );
  }

}