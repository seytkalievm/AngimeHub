import 'package:angime_hub/ui/auth/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../styles.dart';
import '../../../validators.dart';
import '../auth_cubit.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget{
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  bool shown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) =>
            LoginBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loginForm(),
              _registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(){
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed && !shown){
          _showSnackBar(context, formStatus.exception.toString());
          state.copyWith(formStatus: const InitialFormStatus());
          shown = true;
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SafeArea (child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _welcomeText(),
              _emailForm(),
              _passwordForm(),
              _loginButton(),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _welcomeText(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Welcome Back!",
          style: CommonStyle.headingTextStyle(),
        ),
      ),
    );
  }

  Widget _emailForm() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
          child:TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: CommonStyle.textFieldInputStyle(),
            decoration: CommonStyle.textFieldStyle(
              hintTextStr: "E-mail",
              icon: const Icon(Icons.mail),
            ),
            cursorColor: Colors.white,
            validator: emailValidator,
            onChanged: (value) {
              value = value.trim();
              context.read<LoginBloc>().add(LoginEmailChanged(email: value));
            },
          ),
        );
      }
    );
  }


  Widget _passwordForm() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            style: CommonStyle.textFieldInputStyle(),
            decoration: CommonStyle.textFieldStyle(
                hintTextStr: "Password",
                icon: const Icon(Icons.shield),
            ),
            cursorColor: Colors.white,
            validator: passwordValidator,
            onChanged: (value) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password: value)),
          ),
        );
      }
    );
  }

  Widget _loginButton(){
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
      return state.formStatus is FormSubmitting?
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: CircularProgressIndicator(),
        )
          :Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 11, 191, 184)
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Open Sans",
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    shown = false;
                    _formKey.currentState!.save();
                    context.read<LoginBloc>().add(LoginSubmitted());
                }
              }
          ),
      );
    }
  );

  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _registerButton(BuildContext context){
    return TextButton(
      onPressed: (){
        context.read<AuthCubit>().showRegister();
      },
      child: const Text("Don't have an account? Register"),
    );
  }


}