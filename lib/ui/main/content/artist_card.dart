import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/artist/artist_page_view.dart';
import 'package:flutter/material.dart';

import '../../../data/models/artist_model.dart';

class ArtistCard extends StatelessWidget{
  final Artist artist;

  const ArtistCard({required this.artist, Key? key})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (context){
          return ArtistPage(artist: artist);
          }));
          },
        child: Column(
          children: [
            _photo(),
            _name(),
          ],
        ),
      )
    );
  }

  Widget _photo(){
    return  ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(artist.profilePic, height: 97, width: 95),
    );
  }

  Widget _name(){
    return Container(
      height: 16,
      width: 95,
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
      alignment: Alignment.centerLeft,
      child: Text(
        artist.toString(),
        style: CommonStyle.descriptionTextStyle(),
      ),
    );
  }

}