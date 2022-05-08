import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/data/models/user_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BecomeArtistPage extends StatelessWidget {
  late DataRepository dataRepo;
  final User user;

  BecomeArtistPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(
          context: context,
          pageTitle: 'Become an Artist',
          showProfileButton: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _view(),
            _fullNameForm(),
            _countryForm(),
            _becomeArtist(context),
            _cancel(),
          ],
        ),
      ),
    );
  }

  Widget _view() {
    return Container(
      margin: const EdgeInsets.only(top: 34, bottom: 26),
      child: Center(
        child: Column(
          children: [
            _photo(),
            _upload(),
          ],
        ),
      ),
    );
  }

  Widget _photo() {
    return Container(
      width: 72,
      height: 72,
      margin: const EdgeInsets.only(bottom: 4.0),
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 156, 160, 199),
        radius: 100,
        child: Icon(
          MyFlutterApp.account,
          size: 35,
          color: Color.fromARGB(255, 72, 78, 128),
        ),
      ),
    );
  }

  Widget _upload() {
    return const Text(
      "Upload photo",
      style: TextStyle(
        fontFamily: "OpenSans",
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color.fromARGB(255, 11, 191, 184),
      ),
    );
  }

  Widget _fullNameForm() {
    String name = user.firstName + ' ' + user.secondName;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: [
          CommonStyle.formName(formName: "Full name"),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: TextFormField(
              initialValue: name,
              keyboardType: TextInputType.name,
              style: CommonStyle.textFieldInputStyle(),
              decoration: CommonStyle.textField(
                hintTextStr: "Full name",
              ),
              cursorColor: Colors.white,
              onChanged: (value) {
                value = value.trim();
                },
            ),
          ),
        ],
      ),
    );

  }

  Widget _countryForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: [
          CommonStyle.formName(formName: "Country"),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: TextFormField(
              keyboardType: TextInputType.name,
              style: CommonStyle.textFieldInputStyle(),
              decoration: CommonStyle.textField(
                hintTextStr: "Country",
              ),
              cursorColor: Colors.white,
              onChanged: (value) {
                value = value.trim();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _becomeArtist(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 72, 16, 16),
      child: ElevatedButton(
        onPressed: () {
          try{
            dataRepo.becomeArtist(user.email);
            Navigator.pop(context);
          }catch (e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 11, 191, 184)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Become an Artist",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Open Sans",
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _cancel() {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 156, 160, 199)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Open Sans",
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
