import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spoticlone/components/radio_player.component.dart';
import 'package:spoticlone/models/player_data.model.dart';
import 'package:spoticlone/models/song_metadata.dart';

class MusicView extends StatefulWidget {

  final List<SongMetadata> players;
  final int indexPlayer;

  const MusicView({required this.players, required this.indexPlayer, super.key});

  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {

  String title = "";
  String slogan = "";
  String imageUrl = "";
  String url = "";
  int indexPlayer = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  
  @override
  void initState() {
    super.initState();
    setState(() {
      indexPlayer = widget.indexPlayer;
      title = widget.players[indexPlayer].trackName!;
      url = widget.players[indexPlayer].uri!;
      slogan = widget.players[indexPlayer].albumName??"";
      audioPlayer.setUrl(url);
    });

  }

  @override 
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  
  void changePlayer(bool next) {
    setState(() {
      print("#####CHANGE PLAYER#####");
      if (next) {
        indexPlayer = (indexPlayer + 1) % widget.players.length;
      } else {
        indexPlayer = (indexPlayer - 1) % widget.players.length;
      }
      title = widget.players[indexPlayer].trackName!;
      url = widget.players[indexPlayer].uri!;
      slogan = widget.players[indexPlayer].albumName??"";
      audioPlayer.setUrl(url);
    });
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, title);
          return true;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Card(
                  child: 
                    url != "" ?
                      RadioPlayer(audioPlayer: audioPlayer, slogan: slogan, imageUrl: imageUrl, title: title, autoStart: false, withSeekBar: true)
                    : const Text('Aucun lien vers le flux radio n\'a été trouvé.'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Ink(
                  decoration: ShapeDecoration(
                    color: Colors.blueGrey[50],
                    shape: const CircleBorder()  
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.skip_previous, size: 30),
                    onPressed: () => changePlayer(false),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Ink(
                  decoration: ShapeDecoration(
                    color: Colors.blueGrey[50],
                    shape: const CircleBorder()  
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.skip_next, size: 30,),
                    onPressed: () => changePlayer(true),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}