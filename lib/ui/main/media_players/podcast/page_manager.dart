import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/styles.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../content/common.dart';

class PageManager {
  late AudioPlayer _player;
  late final MediaEntity _audio;
  final rewindDuration = const Duration(seconds: 10);
  PageManager ({required MediaEntity audio}){
    _audio = audio;
    _init();
  }

  void _init() async{
    _player = AudioPlayer();
    await _player.setUrl(_audio.url);
    play();

    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else { // completed
        _player.seek(Duration.zero);
        _player.pause();
      }
    });

    _player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _player.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void dispose(){
    _player.dispose();
  }

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  void play() {
    _player.play();
  }
  void pause() {
    _player.pause();
  }

  void seek(Duration position) {
    _player.seek(position);
  }

  void fastForward(){
    if (_player.duration! - _player.position > rewindDuration){
      _player.seek(_player.position + rewindDuration);
    }
    else {
      _player.seek(_player.duration);
    }
  }

  void rewind(){
    if (_player.position <= rewindDuration){
      _player.seek(Duration.zero);
    }
    else{
      _player.seek(_player.position - rewindDuration);
    }
  }

  Widget setPlayBackSpeed({required BuildContext context}){
    return StreamBuilder<double>(
      stream: _player.speedStream,
      builder: (context, snapshot) => IconButton(
        icon: Text(
          "${snapshot.data?.toStringAsFixed(2)}x",
          style: CommonStyle.descriptionTextStyle(),
        ),
        onPressed: () {
          showSliderDialog(
            context: context,
            title: "Adjust speed",
            divisions: 7,
            min: 0.25,
            max: 2.0,
            value: _player.speed,
            stream: _player.speedStream,
            onChanged: _player.setSpeed,
          );
        },
      ),
    );
  }

}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState {
  paused, playing, loading
}