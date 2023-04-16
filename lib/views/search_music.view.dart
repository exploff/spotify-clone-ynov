import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spoticlone/components/radio_player.component.dart';
import 'package:spoticlone/models/player_data.model.dart';
import 'package:spoticlone/models/track.model.dart';

class SearchMusicView extends StatefulWidget {

  final Track song;

  const SearchMusicView({required this.song, super.key});

  @override
  State<SearchMusicView> createState() => _SearchMusicViewState();
}

class _SearchMusicViewState extends State<SearchMusicView> {

  String title = "";
  String slogan = "";
  String imageUrl = "";
  String url = "";
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setState(() {
      url = widget.song.audio!;
      title = widget.song.name!;
      imageUrl =  widget.song.image!;
      slogan = widget.song.artistName!;
      audioPlayer.setUrl(url);
    });

  }

  @override 
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Card(
                child: 
                  url != "" ? 
                    RadioPlayer(audioPlayer: audioPlayer, slogan: slogan, imageUrl: imageUrl, title: title, autoStart: false, withSeekBar: true,)
                  : const Text('Aucun lien vers le flux audio n\'a été trouvé.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}