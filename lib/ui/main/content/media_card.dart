import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/data/models/media_card_model.dart';
import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../media_players/podcast/podcast_player.dart';
import '../media_players/standup/standup_player.dart';

class MediaCard extends StatelessWidget {
  final MediaCardEntity mediaCardEntity;
  late IconData icon = MyFlutterApp.download;
  late DataRepository dataRepo;

  MediaCard({
    required this.mediaCardEntity,
    this.icon = MyFlutterApp.download,
    Key? key,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 18, 16),
      child: InkWell(
        onTap: () async {
          MediaEntity media = await dataRepo.getFullMediaInfo(mediaCardEntity.mediaId);
          Navigator.push(context, MaterialPageRoute<void>(builder: (context){
            if (mediaCardEntity.type == 1) {
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
        mediaCardEntity.previewUrl,
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
        ],
      ),
    );
  }

  Widget _name(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        mediaCardEntity.mediaName,
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
        "${mediaCardEntity.artistFirstName} ${mediaCardEntity.artistSecondName}",
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
