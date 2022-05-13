import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/content/podcasts_view.dart';
import 'package:angime_hub/ui/main/content/standups_view.dart';
import 'package:angime_hub/ui/main/saved/saved_view.dart';
import 'package:angime_hub/ui/navigation/user_bottom_bar/icon.dart';
import 'package:flutter/material.dart';
import '../../../content/icons.dart';



class UserBottomBar extends StatefulWidget{
  final screens = [
    StandUpPage(),
    PodcastsPage(),
  ];

  UserBottomBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserBottomState();
  }
}

class UserBottomState extends State<UserBottomBar>{
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CommonStyle.mainTheme(),
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
              _standUp(),
              _podcasts(),
              _saved(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _standUp(){
    return IconButton(
      iconSize: 32,
      enableFeedback: false,
      onPressed: () {
        setState(() {
         _currentPage = 0;
        });
      },
      icon: BottomBarIcon(
        isSelected: _currentPage == 0,
        icon: MyFlutterApp.standup,
      ),
    );
  }

  Widget _podcasts(){
    return IconButton(
      iconSize: 32,
      enableFeedback: false,
      onPressed: () {
        setState(() {
          _currentPage = 1;
        });
      },
      icon: BottomBarIcon(
        isSelected: _currentPage == 1,
        icon: MyFlutterApp.podcast,
      ),

    );
  }

  Widget _saved(){
    return IconButton(
      iconSize: 32,
      enableFeedback: false,
      onPressed: () {
        setState(() {
          _currentPage = 2;
        });
      },
      icon: BottomBarIcon(
        isSelected: _currentPage == 2,
        icon: MyFlutterApp.saved,
      ),
    );
  }

  Widget getBody() {
    if (_currentPage == 0 || _currentPage == 1) {
      return IndexedStack(
        children: widget.screens,
        index: _currentPage,
      );
    } else {
      return const SavedRecordingsView();
    }
  }


}