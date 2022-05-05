import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/data/models/user_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BecomeArtistPage extends StatelessWidget {
  late DataRepository dataRepo;

  BecomeArtistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 22, 38),
        fontFamily: "Open Sans",
      ),
      home: Scaffold(
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
              _becomeArtist(),
              _cancel(),
            ],
          ),
        ),
      ),
    );
  }

  Future<User> getUser() async {
    final user = await dataRepo.getUser();
    return user;
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
    String name;
    return FutureBuilder<User>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          name = snapshot.data!.firstName + ' ' + snapshot.data!.secondName;
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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

  Widget _becomeArtist() {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 72, 16, 16),
      child: ElevatedButton(
        onPressed: () {},
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
            color: Color.fromARGB(255, 11, 191, 184),
          ),
        ),
      ),
    );
  }

  Widget _cancel() {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 72, 16, 16),
      child: ElevatedButton(
        onPressed: () {},
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
          "Cancel",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Open Sans",
            color: Color.fromARGB(255, 156, 160, 199),
          ),
        ),
      ),
    );
  }
}
