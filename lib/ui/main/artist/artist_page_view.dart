import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';

import '../../../data/models/artist_model.dart';
import '../content/artist_card.dart';

class ArtistPage extends StatelessWidget{

  final Artist artist;
  const ArtistPage({required this.artist, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar(
        context: context,
        pageTitle: "About an Artist",
        showProfileButton: false,
      ),
      body: Column(
        children: [
          ArtistCard(artist: artist),
        ],
      ),
    );

  }
}