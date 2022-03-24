import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'globals.dart' as globals;
import 'icons.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
      'https://storage.yandexcloud.net/angimehub-videos/Shane%20Gillis%20Live%20In%20Austin%20_%20Stand%20Up%20Comedy.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEsFaNYuFUbqIxlXPsL6kD%2F20220324%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20220324T131810Z&X-Amz-Expires=360000&X-Amz-Signature=EF85CD2C61FDB62CA112C44FADD472A87BB1A286A40BDC2FAA306D644B1B9E6E&X-Amz-SignedHeaders=host',
    );
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 20, 22, 38),
            body: SingleChildScrollView(
              child: Column(children: [
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(controller),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 50),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: controller.value.isPlaying
                                ? const SizedBox(height: 80, width: 80)
                                : const Icon(
                                    Icons.replay_5,
                                    color: Color.fromARGB(190, 255, 255, 255),
                                    size: 50.0,
                                  ),
                          ),
                          onDoubleTap: () async {
                            if ((await controller.position)! >
                                const Duration(seconds: 5)) {
                              controller.seekTo((await controller.position)! -
                                  const Duration(seconds: 5));
                            } else {
                              controller.seekTo(const Duration(seconds: 0));
                            }
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 50),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: controller.value.isPlaying
                                ? const SizedBox(height: 80, width: 80)
                                : const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 80.0,
                                  ),
                          ),
                          onTap: () {
                            controller.value.isPlaying
                                ? controller.pause()
                                : controller.play();
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 25),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 50),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: controller.value.isPlaying
                                ? const SizedBox(height: 80, width: 80)
                                : const Icon(
                                    Icons.forward_5,
                                    color: Color.fromARGB(190, 255, 255, 255),
                                    size: 50.0,
                                  ),
                          ),
                          onDoubleTap: () async {
                            if ((await controller.position)! >
                                const Duration(seconds: 5)) {
                              controller.seekTo((await controller.position)! +
                                  const Duration(seconds: 5));
                            } else {
                              controller.seekTo(Duration(
                                  seconds:
                                      controller.value.duration.inSeconds));
                            }
                          },
                        ),
                      ),
                      !controller.value.isPlaying
                          ? Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.seekTo(
                                                  const Duration(seconds: 0));

                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.restart_alt_rounded),
                                            color: Colors.white,
                                            iconSize: 24,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (globals.orientation == 1) {
                                                globals.orientation = 0;
                                                SystemChrome
                                                    .setPreferredOrientations([
                                                  DeviceOrientation.portraitUp
                                                ]);
                                              } else {
                                                globals.orientation = 1;
                                                SystemChrome
                                                    .setPreferredOrientations([
                                                  DeviceOrientation
                                                      .landscapeLeft
                                                ]);
                                              }

                                              setState(() {});
                                            },
                                            icon: Icon(globals.orientation == 1
                                                ? Icons.fullscreen_exit
                                                : Icons.fullscreen),
                                            color: Colors.white,
                                            iconSize: 30,
                                          ),
                                        ]),
                                    VideoProgressIndicator(controller,
                                        allowScrubbing: true,
                                        colors: const VideoProgressColors(
                                          backgroundColor:
                                              Color.fromARGB(172, 42, 45, 71),
                                          playedColor: Colors.white,
                                          bufferedColor: Color.fromARGB(
                                              120, 255, 255, 255),
                                        )),
                                  ]),
                              alignment: Alignment.bottomCenter,
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Name of this show",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        Icon(
                          MyFlutterApp.download,
                          size: 16,
                          color: Color.fromARGB(255, 156, 160, 199),
                        ),
                      ]),
                  margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  child: Row(children: [
                    Container(
                      child: Image.asset('assets/images/3.png',
                          height: 37, width: 35),
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    const Text(
                      "Artist",
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 156, 160, 199)),
                    ),
                  ]),
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  alignment: Alignment.centerLeft,
                ),
              ]),
            )));
  }
}
