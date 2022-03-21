import 'content_page.dart';
import 'package:flutter/material.dart';

class StandUp extends StatelessWidget {
  const StandUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContentPage(
      header: "Stand-Up Shows",
      hint: "Artists or stand-up shows",
      popular: "Popular Stand-Up Shows",
    );
  }
}
