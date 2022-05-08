import 'package:angime_hub/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Empty firstname returns error string', () {
    var result = firstNameValidator('');
    expect(result, "First name is required");
  });

  test('Firstname should have only letters', () {
    var result = firstNameValidator('John 5');
    expect(result, "First name should contain only letters A-Z");
  });

  test('Firstname should start with a capital letter', () {
    var result = firstNameValidator('mark');
    expect(result, "First Name should start with capital letter");
  });

  test('Secondname should have only letters', () {
    var result = secondNameValidator('');
    expect(result, "Second name is required");
  });

  test('Secondname should have only letters', () {
    var result = secondNameValidator('Smith42');
    expect(result, "Second name should contain only letters A-Z");
  });

  test('Secondname should start with a capital letter', () {
    var result = secondNameValidator('brown');
    expect(result, "Second name should start with capital letter");
  });

  test('Email should not be empty', () {
    var result = emailValidator('');
    expect(result, "E-mail is required");
  });

  test('Email should have correct form', () {
    var result = emailValidator('mail');
    expect(result, "Invalid e-mail");
  });

  test('Password should not be empty', () {
    var result = passwordValidator('');
    expect(result, 'Password is required');
  });

  test('Password length >= 6', () {
    var result = passwordValidator('ch3Ck');
    expect(result, 'Password must be at least 6 digits long');
  });

  test('Password should be secure', () {
    var result = passwordValidator('checking');
    expect(result,
        'Password should contain at least:\nOne upper case letter,\nOne lower case letter,\nOne number');
  });
}
