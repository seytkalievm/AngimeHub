import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/styles.dart';
import 'package:flutter/material.dart';

class StandUpPlayer extends StatefulWidget{
  final MediaEntity standUp;

  const StandUpPlayer({required this.standUp, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StandUpPlayerState();
  }
}

class _StandUpPlayerState extends State<StandUpPlayer>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.standUp.toString(),
          style: CommonStyle.descriptionTextStyle(),
        ),
      ),
    );
  }

}