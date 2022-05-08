import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/ui/main/media_players/common_components.dart';
import 'package:angime_hub/ui/main/media_players/podcast/page_manager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:angime_hub/styles.dart';
import 'package:flutter/material.dart';

class PodcastPlayer extends StatefulWidget {
  final MediaEntity audio;
  const PodcastPlayer({required this.audio, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PodcastPlayerState();
  }
}

class _PodcastPlayerState extends State<PodcastPlayer>{
  late final PageManager _pageManager;
  double currentPlaybackSpeed = 1.0;
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
      body: Column(
        children: [
          _cover(),
          _progressBar(),
          _controls(),
          info(mediaQuery: MediaQuery.of(context), media: widget.audio)
        ],
      ),
    );
  }

  Widget _cover() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      height: MediaQuery.of(context).size.width - 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(widget.audio.preview),
        ),
      ),
    );
  }

  Widget _progressBar() {
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16),
      child: ValueListenableBuilder<ProgressBarState>(
        valueListenable: _pageManager.progressNotifier,
        builder: (_, value, __) {
          return ProgressBar(
            timeLabelTextStyle: CommonStyle.descriptionTextStyle(),
            progress: value.current,
            progressBarColor: Colors.white,
            baseBarColor: const Color.fromARGB(255, 42, 45, 71),
            bufferedBarColor: const Color.fromARGB(255, 133, 135, 159),
            thumbColor: Colors.white,
            onSeek: _pageManager.seek,
            buffered: value.buffered,
            total: value.total,
          );
        },
      ),
    );
  }

  Widget _controls() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: _replayButton(),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: _setPlaybackSpeed(context: context),
        ),
        SizedBox(
          width: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: _rewindButton(),
              ),
              Container(
                alignment: Alignment.center,
                child: _playButton(),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: _fastForwardButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _playButton() {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.buttonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 55,
              height: 55,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              color: Colors.white,
              iconSize: 55,
              onPressed: () {
                _pageManager.play();
              },
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              color: Colors.white,
              iconSize: 55,
              onPressed: () {
                _pageManager.pause();
              },
            );
        }
      },
    );
  }

  Widget _fastForwardButton() {
    return IconButton(
      icon: const Icon(Icons.forward_10),
      color: Colors.white,
      iconSize: 32.0,
      onPressed: () {
        _pageManager.fastForward();
      },
    );
  }

  Widget _rewindButton() {
    return IconButton(
      icon: const Icon(Icons.replay_10),
      color: Colors.white,
      iconSize: 32.0,
      onPressed: () {
        _pageManager.rewind();
      },
    );
  }

  Widget _replayButton() {
    return IconButton(
      icon: const Icon(Icons.restart_alt_rounded),
      color: const Color.fromARGB(255, 156, 160, 199),
      iconSize: 30,
      onPressed: () {
        _pageManager.replay();
      },
    );
  }

  Widget _setPlaybackSpeed({required BuildContext context}) {
    return Container(
      child: _pageManager.setPlayBackSpeed(context: context),
    );
  }
}
