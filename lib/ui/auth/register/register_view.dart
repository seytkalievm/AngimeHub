import 'package:angime_hub/ui/auth/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../styles.dart';
import '../../../validators.dart';
import '../auth_cubit.dart';
import '../form_submission_status.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  bool shown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => RegisterBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _registerForm(context),
                _logInButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed && !shown) {
          _showSnackBar(context, formStatus.exception.toString());
          state.copyWith(formStatus: const InitialFormStatus());
          shown = true;
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _welcomeText(),
                _firsNameForm(),
                _secondNameForm(),
                _emailForm(),
                _passwordForm(),
                _confPasswordForm(),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _welcomeText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Create an Account",
          style: CommonStyle.headingTextStyle(),
        ),
      ),
    );
  }

  Widget _firsNameForm() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            children: [
              CommonStyle.formName(formName: "First name"),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: CommonStyle.textFieldInputStyle(),
                  decoration: CommonStyle.textField(
                    hintTextStr: "First name",
                  ),
                  cursorColor: Colors.white,
                  validator: firstNameValidator,
                  onChanged: (firstName) {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterFirstNameChanged(firstName.trim()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _secondNameForm() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            children: [
              CommonStyle.formName(formName: "Second name"),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: CommonStyle.textFieldInputStyle(),
                  decoration: CommonStyle.textField(
                    hintTextStr: "Second name",
                  ),
                  cursorColor: Colors.white,
                  validator: secondNameValidator,
                  onChanged: (secondName) {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterSecondNameChanged(secondName.trim()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _emailForm() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            children: [
              CommonStyle.formName(formName: "Email"),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: CommonStyle.textFieldInputStyle(),
                  decoration: CommonStyle.textField(
                    hintTextStr: "Email",
                  ),
                  cursorColor: Colors.white,
                  validator: emailValidator,
                  onChanged: (email) {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterEmailChanged(email.trim()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _passwordForm() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            children: [
              CommonStyle.formName(formName: "Password"),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  style: CommonStyle.textFieldInputStyle(),
                  controller: passwordController,
                  decoration: CommonStyle.textField(
                    hintTextStr: "Password",
                  ),
                  cursorColor: Colors.white,
                  validator: passwordValidator,
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(RegisterPasswordChanged(password)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _confPasswordForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: [
          CommonStyle.formName(formName: "Confirm password"),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: TextFormField(
              keyboardType: TextInputType.name,
              obscureText: true,
              style: CommonStyle.textFieldInputStyle(),
              controller: confPasswordController,
              decoration: CommonStyle.textField(
                hintTextStr: "Confirm password",
              ),
              cursorColor: Colors.white,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Confirm password";
                } else if (confPasswordController.text !=
                    passwordController.text) {
                  return "Passwords don't match";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 11, 191, 184)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Open Sans",
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      shown = false;
                      context.read<RegisterBloc>().add(RegisterSubmitted());
                    }
                  }),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _logInButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AuthCubit>().showLogIn();
      },
      child: const Text("Already have an account? Sign in"),
    );
  }
}
