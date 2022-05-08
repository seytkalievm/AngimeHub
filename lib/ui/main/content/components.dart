import 'package:angime_hub/ui/main/content/artist_media_card.dart';
import 'package:angime_hub/ui/main/profile/profile_view.dart';
import 'package:angime_hub/ui/main/profile/user_profile_view.dart';
import 'package:flutter/material.dart';
import '../../../content/icons.dart';
import '../../../data/models/artist_model.dart';
import '../../../data/models/media_model.dart';
import '../../../styles.dart';
import 'artist_card.dart';
import 'media_card.dart';

AppBar appBar({
  required BuildContext context,
  required String pageTitle,
  required bool showProfileButton,
}) {
  return AppBar(
    elevation: 3,
    toolbarHeight: 80,
    backgroundColor: CommonStyle.mainColor(),
    title: Text(
      pageTitle,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          fontFamily: "OpenSans",
          color: Color.fromARGB(255, 255, 255, 255)),
    ),
    actions: showProfileButton ? <Widget>[profileButton(context)] : [],
  );
}

Widget profileButton(BuildContext context) {
  return SizedBox(
    width: 50,
    height: 50,
    child: IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) {
            return const ProfilePage();
          }),
        );
      },
      icon: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 156, 160, 199),
        radius: 32,
        child: Icon(
          MyFlutterApp.account,
        ),
      ),
    ),
  );
}

Widget searchField(String hint) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 34),
    child: TextField(
      textInputAction: TextInputAction.search,
      style: CommonStyle.textFieldInputStyle(),
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        fillColor: CommonStyle.secondaryColor(),
        hintStyle: CommonStyle.descriptionTextStyle(),
        contentPadding: const EdgeInsets.fromLTRB(0, 13.5, 15, 13.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 11, 10, 11),
          child: Icon(
            Icons.search,
            color: Color.fromARGB(255, 133, 135, 159),
            size: 20,
          ),
        ),
      ),
    ),
  );
}

Widget sectionTitle(String title) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 133, 135, 159),
        ),
      ),
    ),
  );
}

Widget artistsList({required Future<List<Artist>> artistsFuture}) {
  List<Artist> popularArtists;
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
    child: SizedBox(
      height: 125,
      child: FutureBuilder<List<Artist>>(
        future: artistsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Artist>> snapshot) {
          if (snapshot.hasData) {
            popularArtists = snapshot.data!;
            return ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                popularArtists.length,
                (index) {
                  Artist current = popularArtists[index];
                  return ArtistCard(artist: current);
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
  );
}

Widget showsList({required Future<List<MediaEntity>> showsFuture}) {
  List<MediaEntity> shows;
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
    child: SizedBox(
      child: FutureBuilder<List<MediaEntity>>(
        future: showsFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<MediaEntity>> snapshot) {
          if (snapshot.hasData) {
            shows = snapshot.data!;
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                shows.length,
                (index) {
                  MediaEntity current = shows[index];
                  return MediaCard(media: current);
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
  );
}

Widget showsListForArtist({required Future<List<MediaEntity>> showsFuture}) {
  List<MediaEntity> shows;
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
    child: SizedBox(
      child: FutureBuilder<List<MediaEntity>>(
        future: showsFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<MediaEntity>> snapshot) {
          if (snapshot.hasData) {
            shows = snapshot.data!;
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                shows.length,
                (index) {
                  MediaEntity current = shows[index];
                  return ArtistMediaCard(media: current);
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
  );
}
