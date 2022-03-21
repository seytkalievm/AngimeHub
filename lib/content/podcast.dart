import 'content_page.dart';
import 'package:flutter/material.dart';

class Podcast extends StatelessWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContentPage(
      header: "Podcasts",
      hint: "Artists or podcasts",
      popular: "Popular Podcasts",
    );
  }
}
