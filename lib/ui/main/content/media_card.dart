import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/data/models/media_model.dart';
import 'package:flutter/material.dart';

import '../media_players/podcast/podcast_player.dart';
import '../media_players/standup/standup_player.dart';

class MediaCard extends StatelessWidget {
  final MediaEntity media;
  late IconData icon = MyFlutterApp.download;

  MediaCard({required this.media, this.icon = MyFlutterApp.download, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 18, 16),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (context){
            if (media.type == 0) {
              return PodcastPlayer(audio: media);
            }
            return StandUpPlayer(standUp: media);
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _preview(),
                Stack(
                  alignment:  Alignment.centerLeft,
                  children: [
                    _info(),
                  ],
                )
              ],
            ),
            _saveToFavourites(),
          ],
        ),
      ),
    );

  }

  Widget _preview(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        media.preview,
        height: 60,
        width: 83,
      ),
    );
  }

  Widget _info(){
    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _name(),
          _artist(),
          _duration(),
        ],
      ),
    );
  }

  Widget _name(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        media.name,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _artist(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        media.artist.toString(),
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 156, 160, 199),
        ),
      ),
    );
  }

  Widget _duration(){
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        media.duration,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 156, 160, 199),
        ),
      ),
    );
  }

  Widget _saveToFavourites(){
    return SizedBox(
      child: IconButton(
        color: const Color.fromARGB(255, 156, 160, 199),
        icon: Icon(
          icon,
          size: 16,
        ),
        onPressed: () {},
      ),
    );
  }
}
