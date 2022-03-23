import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/content/profile.dart';
import 'package:angime_hub/content/video.dart';
import 'package:flutter/material.dart';
import 'content_page.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SavedPageState();
}

class SavedPageState extends State<SavedPage> {
  final String header = "Saved Recordings";
  final String hint = "Artists, stand-up shows, podcasts";
  final String popular = "Saved Stand-up shows and Podcasts";
  int page = 0;

  @override
  Widget build(BuildContext context) {
    if (page == 0) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color.fromARGB(255, 20, 22, 38),
              body: SingleChildScrollView(
                child: Column(children: [
                  Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Text(
                                  header,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      fontFamily: "OpenSans",
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                height: 38,
                              ),
                              Center(
                                  child: InkWell(
                                child: const SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 156, 160, 199),
                                      radius: 32,
                                      child: Icon(
                                        MyFlutterApp.account,
                                        size: 20,
                                      ),
                                    )),
                                onTap: () {
                                  switchToProf();
                                },
                              ))
                            ]),
                        margin: const EdgeInsets.fromLTRB(16, 40, 16, 10),
                      ),
                      Container(
                        child: TextField(
                            style: const TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            decoration: InputDecoration(
                                prefixIcon: const Padding(
                                  child: Icon(
                                    Icons.search,
                                    color: Color.fromARGB(255, 133, 135, 159),
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.fromLTRB(20, 11, 10, 11),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                hintText: hint,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 133, 135, 159),
                                    fontFamily: "OpenSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                fillColor:
                                    const Color.fromARGB(255, 42, 45, 71),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0, 13.5, 15, 13.5))),
                        height: 46,
                        margin: const EdgeInsets.fromLTRB(16, 10, 16, 34),
                      ),
                      InkWell(
                        child: PopularShows(
                            popular: popular, icon: MyFlutterApp.saved),
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return VideoPage();
                              });
                        },
                      )
                    ],
                  )
                ]),
              )));
    } else {
      return const ProfilePage();
    }
  }

  switchToProf() {
    setState(() {
      page = 1;
    });
  }
}
