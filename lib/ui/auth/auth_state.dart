part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class LogIn extends AuthState {}

class Register extends AuthState {}