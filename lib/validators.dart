import 'package:form_field_validator/form_field_validator.dart';

class NameValidator extends TextFieldValidator {
  NameValidator(String errorText) : super(errorText);

  @override
  bool isValid(String? value) {
    return value == null || value.isEmpty;
  }
}

class EmailValidator extends TextFieldValidator {
  EmailValidator(String errorText) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null || value.isEmpty || !value.contains("@")) {
      return false;
    }
    return true;
  }
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character'),
]);
