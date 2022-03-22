import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/content/user_bottom.dart';
import 'package:flutter/widgets.dart';
import 'content_page.dart';
import 'package:flutter/material.dart';

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
                  Container(
                    child: const Text(
                      "My Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          fontFamily: "OpenSans",
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    alignment: Alignment.centerLeft,
                    height: 38,
                    margin: const EdgeInsets.fromLTRB(16, 40, 16, 41),
                  ),
                  const ShowInfo(),
                  Container(
                    height: 42,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 11, 191, 184)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  ),
                  Container(
                    height: 42,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 156, 160, 199)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  ),
                ]))));
  }
}

class ShowInfo extends StatefulWidget {
  const ShowInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShowInfoState();
}

class ShowInfoState extends State<ShowInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 48,
        width: 48,
        child: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 156, 160, 199),
          radius: 100,
          child: Icon(
            MyFlutterApp.account,
            size: 32,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 16),
      ),
      Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 72),
          child: Center(
              child: Column(children: const [
            Text(
              "Ida Strong",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Text("idastrong@gmail.com",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)))
          ])))
    ]);
  }
}
