import 'package:angime_hub/content/content_page.dart';
import 'package:angime_hub/content/profile.dart';
import 'package:flutter/rendering.dart';
import 'globals.dart' as globals;
import 'icons.dart';
import 'podcast.dart' as podcast;
import 'saved.dart' as saved;
import 'stand_up.dart' as stand_up;
import 'package:flutter/material.dart';

class UserBottom extends StatefulWidget {
  const UserBottom({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserBottomState();
}

class UserBottomState extends State<UserBottom> {
  Widget podcastPage = const podcast.Podcast();
  Widget savedPage = const saved.SavedPage();
  Widget standUpPage = const stand_up.StandUp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: getBody(),
          bottomNavigationBar: Container(
            height: 54,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 42, 45, 71)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      iconSize: 32,
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          globals.selectedIndex = 0;
                        });
                      },
                      icon: globals.selectedIndex == 0
                          ? Column(
                              children: [
                                const Icon(
                                  MyFlutterApp.standup,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 11, 191, 184),
                                  height: 2,
                                  width: 24,
                                  margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
                                )
                              ],
                            )
                          : Column(children: [
                              const Icon(
                                MyFlutterApp.standup,
                                color: Color.fromARGB(255, 156, 160, 199),
                                size: 24,
                              ),
                              Container(
                                color: const Color.fromARGB(255, 42, 45, 71),
                                height: 2,
                                width: 24,
                                margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
                              )
                            ])),
                  IconButton(
                      iconSize: 32,
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          globals.selectedIndex = 1;
                        });
                      },
                      icon: globals.selectedIndex == 1
                          ? Column(
                              children: [
                                const Icon(
                                  MyFlutterApp.podcast,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 11, 191, 184),
                                  height: 2,
                                  width: 24,
                                  margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
                                )
                              ],
                            )
                          : Column(children: [
                              const Icon(
                                MyFlutterApp.podcast,
                                color: Color.fromARGB(255, 156, 160, 199),
                                size: 24,
                              ),
                              Container(
                                color: const Color.fromARGB(255, 42, 45, 71),
                                height: 2,
                                width: 24,
                                margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
                              )
                            ])),
                  IconButton(
                      iconSize: 32,
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          globals.selectedIndex = 2;
                        });
                      },
                      icon: globals.selectedIndex == 2
                          ? Column(
                              children: [
                                const Icon(
                                  MyFlutterApp.saved,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 11, 191, 184),
                                  height: 2,
                                  width: 24,
                                  margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
                                )
                              ],
                            )
                          : Column(children: [
                              const Icon(
                                MyFlutterApp.saved,
                                color: Color.fromARGB(255, 156, 160, 199),
                                size: 24,
                              ),
                              Container(
                                color: const Color.fromARGB(255, 42, 45, 71),
                                height: 2,
                                width: 24,
                                margin: const EdgeInsets.fromLTRB(1, 6, 1, 0),
                              )
                            ])),
                ]),
          )),
    );
  }

  Widget getBody() {
    if (globals.selectedIndex == 0) {
      return standUpPage;
    } else if (globals.selectedIndex == 1) {
      return podcastPage;
    } else if (globals.selectedIndex == 2) {
      return savedPage;
    } else {
      return const ProfilePage();
    }
  }

  void onTapHandler(int index) {
    setState(() {
      Navigator.pop(context);
      globals.selectedIndex = index;
    });
  }
}
