

class IncorrectCredentials implements Exception{
  String message = "Wrong email or password";

  @override
  String toString() => message;
}

class UserAlreadyExists implements Exception{
  String message = "User with such email already exists";

  @override
  String toString() => message;
}

