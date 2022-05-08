part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}


class RegisterFirstNameChanged extends RegisterEvent{
  final String firstName;

  RegisterFirstNameChanged(this.firstName);
}

class RegisterSecondNameChanged extends RegisterEvent{
  final String secondName;

  RegisterSecondNameChanged(this.secondName);
}

class RegisterEmailChanged extends RegisterEvent{
  final String email;

  RegisterEmailChanged(this.email);
}

class RegisterPasswordChanged extends RegisterEvent{
  final String password;
  RegisterPasswordChanged(this.password);
}

class RegisterSubmitted extends RegisterEvent{}