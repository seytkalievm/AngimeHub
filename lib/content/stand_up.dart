import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/content/requests.dart';

import 'content_page.dart';
import 'package:flutter/material.dart';

class StandUp extends StatelessWidget {
  const StandUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentPage(
      header: "Stand-Up Shows",
      hint: "Artists or stand-up shows",
      popular: "Popular Stand-Up Shows",
      icon: MyFlutterApp.download,
      popularArtists: popularArtistsList(),
      popularShows: popularShowsList(),
    );
  }
}
