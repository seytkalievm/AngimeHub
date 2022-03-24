import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';
import 'icons.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AudioPageState();
}

class AudioPageState extends State<AudioPage> with WidgetsBindingObserver {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player.playbackEventStream
        .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(255, 20, 22, 38),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width - 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://influencermarketing.ai/wp-content/uploads/2020/05/Podcast-blog-6.jpg"),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  ),
                  StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition:
                            positionData?.bufferedPosition ?? Duration.zero,
                        onChangeEnd: player.seek,
                      );
                    },
                  ),
                  ControlButtons(player),
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
                ],
              ),
            ),
          ),
        ));
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            alignment: Alignment.center,
            child: StreamBuilder<PlayerState>(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 64.0,
                    height: 64.0,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 64.0,
                    onPressed: player.play,
                    color: Colors.white,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 64.0,
                    onPressed: player.pause,
                    color: Colors.white,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 64.0,
                    onPressed: () => player.seek(Duration.zero),
                  );
                }
              },
            )),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 30.0,
            color: const Color.fromARGB(255, 133, 135, 159),
            onPressed: () => player.seek(Duration.zero),
          ),
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            alignment: Alignment.centerRight,
            child: StreamBuilder<double>(
              stream: player.speedStream,
              builder: (context, snapshot) => IconButton(
                icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "OpenSans",
                        color: Color.fromARGB(255, 133, 135, 159))),
                onPressed: () {
                  showSliderDialog(
                    context: context,
                    title: "Adjust speed",
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: player.speed,
                    stream: player.speedStream,
                    onChanged: player.setSpeed,
                  );
                },
              ),
            )),
      ],
    );
  }
}
