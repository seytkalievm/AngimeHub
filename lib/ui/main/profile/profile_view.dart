import 'package:angime_hub/data/database/user/user_database.dart';
import 'package:angime_hub/data/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../../content/icons.dart';

Future<User> getUser() async {
  final db = UserDatabase.instance;
  final user = await db.getUser();
  return user;
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 20, 22, 38),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  _header(),
                  _info(),
                  _becomeArtist(),
                  _signOut()
                ]))));
  }
}

Widget _header() {
  return Container(
    alignment: Alignment.centerLeft,
    height: 38,
    margin: const EdgeInsets.fromLTRB(16, 40, 16, 41),
    child: const Text(
      "My Profile",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          fontFamily: "OpenSans",
          color: Color.fromARGB(255, 255, 255, 255)),
    ),
  );
}

Widget _info() {
  return Column(
    children: [_photo(), _contacts()],
  );
}

Widget _photo() {
  return Container(
    height: 48,
    width: 48,
    margin: const EdgeInsets.only(bottom: 16),
    child: const CircleAvatar(
      backgroundColor: Color.fromARGB(255, 156, 160, 199),
      radius: 100,
      child: Icon(
        MyFlutterApp.account,
        size: 32,
      ),
    ),
  );
}

Widget _contacts() {
  String name;
  String email;
  return FutureBuilder<User>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          name = snapshot.data!.firstName + " " + snapshot.data!.secondName;
          email = snapshot.data!.email;
          return Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 72),
              child: Center(
                  child: Column(children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Text(email,
                    style: const TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 255, 255, 255)))
              ])));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}

Widget _becomeArtist() {
  return Container(
    height: 42,
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _signOut() {
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
        "Sign Out",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Open Sans",
          color: Colors.white,
        ),
      ),
    ),
  );
}
