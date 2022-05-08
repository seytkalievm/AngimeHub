import 'package:angime_hub/data/models/media_card_model.dart';
import 'package:flutter/material.dart';

import '../../../content/icons.dart';
import '../content/components.dart';
import '../content/media_card.dart';

class AllShows extends StatelessWidget{
  late String pageTitle;
  final List<MediaCardEntity> shows;
  final int type;
  AllShows({
    required this.shows,
    required this.type,
    Key? key,
  }) : super(key: key){
   pageTitle = type == 1? "All Podcasts" : "All StandUp Shows";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        pageTitle: pageTitle,
        showProfileButton: false,
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            shows.length,
                (index) {
              MediaCardEntity current = shows[index];
              return MediaCard(
                mediaCardEntity: current,
                icon: MyFlutterApp.saved,
              );
            },
          ),
        ),
      ),
    );
  }
}