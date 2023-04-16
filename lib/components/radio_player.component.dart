import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'seekbar.component.dart';
import 'controlbuttons.component.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spoticlone/models/position_data.model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spoticlone/models/player_data.model.dart';

class RadioPlayer extends StatefulWidget {

  AudioPlayer audioPlayer;
  String title;
  String imageUrl;
  bool autoStart;
  bool withSeekBar;
  String slogan;

  RadioPlayer({required this.audioPlayer, required this.title, required this.imageUrl, required this.autoStart, required this.slogan, required this.withSeekBar, super.key});

  RadioPlayer.withoutSeekBar({required this.audioPlayer, required this.title, required this.imageUrl, required this.slogan, required this.autoStart, super.key, this.withSeekBar = false});
  
  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {

    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    widget.audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      
      //await audioPlayer.setUrl(url);

      if (widget.autoStart) {
        await widget.audioPlayer.play();
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.audioPlayer.stop();
    }
  }



  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          widget.audioPlayer.positionStream,
          widget.audioPlayer.bufferedPositionStream,
          widget.audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
              

  Widget seekBar() {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition:
              positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: widget.audioPlayer.seek,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.imageUrl == "" ?
              Icon(Icons.audiotrack, size: 100, color: Colors.grey[400],) :
              Image.network(widget.imageUrl, width: 350, height: 300,),
              Center(
                child: Text(widget.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ),
              Text(widget.slogan),
              ControlButtons(widget.audioPlayer),
              if (widget.withSeekBar) seekBar()
            ]
          )
        ),
      ),
    );
  }
}