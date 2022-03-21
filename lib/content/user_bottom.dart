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
  int selectedIndex = 0;
  Widget podcastPage = const podcast.Podcast();
  Widget savedPage = const saved.Saved();
  Widget standUpPage = const stand_up.StandUp();
  late final TabController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 42, 45, 71),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                standUpPage,
                podcastPage,
                savedPage,
              ],
            ),
            bottomNavigationBar: const TabBar(
                unselectedLabelColor: Color.fromARGB(255, 156, 160, 199),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromARGB(255, 11, 191, 184),
                indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                tabs: [
                  SizedBox(
                    child: Tab(
                      child: Icon(
                        MyFlutterApp.standup,
                      ),
                    ),
                    height: 54,
                  ),
                  SizedBox(
                    child: Tab(
                      child: Icon(MyFlutterApp.podcast),
                    ),
                    height: 54,
                  ),
                  SizedBox(
                    child: Tab(
                      child: Icon(MyFlutterApp.saved),
                    ),
                    height: 54,
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return standUpPage;
    } else if (selectedIndex == 1) {
      return podcastPage;
    } else {
      return savedPage;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
