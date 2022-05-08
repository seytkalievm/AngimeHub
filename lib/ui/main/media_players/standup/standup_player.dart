import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/ui/main/media_players/common_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class StandUpPlayer extends StatefulWidget {
  final MediaEntity standUp;

  const StandUpPlayer({required this.standUp, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StandUpPlayerState();
  }
}

class _StandUpPlayerState extends State<StandUpPlayer> {
  late VideoPlayerController controller;
  int orientation = 0;
  int orientationIcon = 0;
  bool _showInfo = true;
  bool _showControls = true;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(widget.standUp.url);
    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(false);
    controller.initialize().then((value) {
      setState(() {});
    });
    controller.setVolume(1.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _showVideo(),
            _showInfo ? info(media: widget.standUp) : Container()
          ],
        ),
      ),
    );
  }

  Widget _showVideo() {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _player(),
            _replayBack(),
            _playPause(),
            _replayForward(),
            !controller.value.isPlaying
                ? _bottomControls()
                : const SizedBox.shrink()
          ],
        ),
      ),
      onTap: () async {
        _showControls = true;
        setState(() {});
        await Future.delayed(Duration(seconds: 2));
        controller.value.isPlaying ? _showControls = false : null;
        setState(() {});
      },
    );
  }

  Widget _player() {
    return _fill();
  }

  Widget _fill() {
    final size = controller.value.size;
    final double maxwidth = MediaQuery.of(context).size.width;
    final double maxheight = MediaQuery.of(context).size.height;
    final double width = size.width;
    final double height = size.height;
    double newWidth = width;
    double newHeight = height;

    if (width > height) {
      newWidth = maxwidth;
      return SizedBox(
        width: newWidth,
        child: VideoPlayer(controller),
      );
    } else {
      newHeight = maxheight;
      return SizedBox(
        height: newHeight,
        child: VideoPlayer(controller),
      );
    }
  }

  Widget _replayBack() {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      alignment: Alignment.centerLeft,
      child: InkWell(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: _showControls == false
              ? const SizedBox(height: 80, width: 80)
              : const Icon(
                  Icons.replay_10,
                  color: Color.fromARGB(190, 255, 255, 255),
                  size: 50.0,
                ),
        ),
        onDoubleTap: () async {
          if ((await controller.position)! > const Duration(seconds: 10)) {
            controller.seekTo(
                (await controller.position)! - const Duration(seconds: 10));
          } else {
            controller.seekTo(const Duration(seconds: 0));
          }
        },
      ),
    );
  }

  Widget _playPause() {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: _showControls == false
              ? const SizedBox(height: 80, width: 80)
              : const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 80.0,
                ),
        ),
        onTap: () {
          controller.value.isPlaying
              ? {controller.pause(), _showControls = true}
              : {controller.play(), _showControls = false};
        },
      ),
    );
  }

  Widget _replayForward() {
    return Container(
      margin: const EdgeInsets.only(right: 25),
      alignment: Alignment.centerRight,
      child: InkWell(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: _showControls == false
              ? const SizedBox(height: 80, width: 80)
              : const Icon(
                  Icons.forward_10,
                  color: Color.fromARGB(190, 255, 255, 255),
                  size: 50.0,
                ),
        ),
        onDoubleTap: () async {
          if (((await controller.position)! + const Duration(seconds: 10)) <
              controller.value.duration) {
            controller.seekTo(
                (await controller.position)! + const Duration(seconds: 10));
          } else {
            controller
                .seekTo(Duration(seconds: controller.value.duration.inSeconds));
          }
        },
      ),
    );
  }

  Widget _bottomControls() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _replay(),
              _orientationChange(),
            ]),
            _progressIndicator(),
          ]),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _replay() {
    return IconButton(
      onPressed: () {
        controller.seekTo(const Duration(seconds: 0));
        setState(() {});
      },
      icon: const Icon(Icons.restart_alt_rounded),
      color: Colors.white,
      iconSize: 24,
    );
  }

  Widget _orientationChange() {
    return IconButton(
      onPressed: () {
        _change();
        setState(() {});
      },
      icon:
          Icon(orientationIcon == 1 ? Icons.fullscreen_exit : Icons.fullscreen),
      color: Colors.white,
      iconSize: 30,
    );
  }

  void _change() {
    final size = controller.value.size;
    final double width = size.width;
    final double height = size.height;
    if (height > width) {
      if (orientationIcon == 0) {
        _showInfo = false;
      } else {
        _showInfo = true;
      }
    } else {
      if (orientation == 1) {
        _showInfo = true;
        orientation = 0;
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      } else {
        _showInfo = false;
        orientation = 1;
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
      }
    }
    if (orientationIcon == 0) {
      orientationIcon = 1;
    } else {
      orientationIcon = 0;
    }
  }

  Widget _progressIndicator() {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      colors: const VideoProgressColors(
        backgroundColor: Color.fromARGB(172, 42, 45, 71),
        playedColor: Colors.white,
        bufferedColor: Color.fromARGB(120, 255, 255, 255),
      ),
    );
  }
}
