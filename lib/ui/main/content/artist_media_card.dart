import 'package:angime_hub/content/icons.dart';
import 'package:flutter/material.dart';

import '../../../data/models/media_card_model.dart';

class ArtistMediaCard extends StatelessWidget {
  final MediaCardEntity media;
  final IconData icon = MyFlutterApp.remove;

  const ArtistMediaCard({required this.media, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 18, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _preview(),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  _info(),
                ],
              )
            ],
          ),
          _saveToFavourites(),
        ],
      ),
    );
  }

  Widget _preview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        media.previewUrl,
        height: 60,
        width: 83,
      ),
    );
  }

  Widget _info() {
    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _name(),
          _views(),
        ],
      ),
    );
  }

  Widget _name() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        media.mediaName,
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

  Widget _views() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: const Text(
        'views',
        style: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 156, 160, 199),
        ),
      ),
    );
  }

  Widget _saveToFavourites() {
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
