import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/ui/main/media_players/podcast/page_manager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:angime_hub/styles.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PodcastPlayer extends StatefulWidget{

  final MediaEntity audio;
  const PodcastPlayer({required this.audio, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PodcastPlayerState();
  }

}


class _PodcastPlayerState extends State<PodcastPlayer>{
  late final PageManager _pageManager;

  @override
  void initState(){
    super.initState();
    _pageManager = PageManager(audio: widget.audio);
  }


  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            progressBar(),
            controls(),
          ],
        ),
      ),
    );
  }

  Widget cover(){
    return Container(
      height: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              widget.audio.preview),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
    );
  }

  Widget progressBar(){
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          timeLabelTextStyle: CommonStyle.descriptionTextStyle(),
          progress: value.current,
          onSeek: _pageManager.seek,
          buffered: value.buffered,
          total: value.total,
        );
      },
    );
  }


  Widget controls(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        playButton(),
      ],
    );
  }

  Widget playButton(){
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.buttonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              color: Colors.white,
              iconSize: 32.0,
              onPressed: () {
                _pageManager.play();
              },
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              color: Colors.white,
              iconSize: 32.0,
              onPressed: () {
                _pageManager.pause();
              },
            );
        }
      },
    );
  }

}