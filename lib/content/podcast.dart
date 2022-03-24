import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/content/requests.dart';

import 'content_page.dart';
import 'package:flutter/material.dart';

class Podcast extends StatelessWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentPage(
      header: "Podcasts",
      hint: "Artists or podcasts",
      popular: "Popular Podcasts",
      icon: MyFlutterApp.download,
      popularArtists: popularArtistsList(),
      popularShows: popularShowsList(),
    );
  }
}
