import 'package:form_field_validator/form_field_validator.dart';

class NameValidator extends TextFieldValidator {
  NameValidator(String errorText) : super(errorText);

  var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])$';
  @override
  bool isValid(String? value) {
    return value == null || value.isEmpty || RegExp(pattern).hasMatch(value);
  }
}

class EmailValidator extends TextFieldValidator {
  EmailValidator(String errorText) : super(errorText);
  var pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  bool isValid(String? value) {
    return RegExp(pattern).hasMatch(value!);
  }
}

final firstNameValidator = MultiValidator([
  RequiredValidator(errorText: "First name is required"),
  PatternValidator(r"^[a-zA-Z]+[a-zA-Z ,.'-]+$",
      errorText: "First name should contain only letters A-Z"),
  PatternValidator(r"^[A-Z]+[a-zA-Z ,.'-]+$",
      errorText: "First Name should start with capital letter")
]);

final secondNameValidator = MultiValidator([
  RequiredValidator(errorText: "Second name is required"),
  PatternValidator(r"^[a-zA-Z ,.'-]+$",
      errorText: "Second name should contain only letters A-Z"),
  PatternValidator(r"^[A-Z]+[a-zA-Z ,.'-]+$",
      errorText: "Second name should start with capital letter")
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: "E-mail is required"),
  EmailValidator("Invalid e-mail")
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
  PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$',
      errorText:
          'Password should contain at least:\nOne upper case letter,\nOne lower case letter,\nOne number'),
]);
