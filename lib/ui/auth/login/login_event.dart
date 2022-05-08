
abstract class LoginEvent{}


class LoginEmailChanged extends LoginEvent{
  late String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent{
  final String password;

  LoginPasswordChanged({required this.password});
}


class LoginSubmitted extends LoginEvent{
}