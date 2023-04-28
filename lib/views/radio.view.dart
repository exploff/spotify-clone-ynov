import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spoticlone/components/radio_player.component.dart';
import 'package:spoticlone/models/player_data.model.dart';

class RadioView extends StatefulWidget {

  final List<PlayerData> players;
  final int indexPlayer;

  const RadioView({required this.players, required this.indexPlayer, super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {

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
      url = widget.players[indexPlayer].url!;
      title = widget.players[indexPlayer].title!;
      imageUrl =  widget.players[indexPlayer].imageUrl!;
      slogan = widget.players[indexPlayer].slogan!;
    });

  }

  @override 
  void dispose() {
    super.dispose();
  }
  
  void changePlayer(bool next) {
    setState(() {
      if (next) {
        indexPlayer = (indexPlayer + 1) % widget.players.length;
      } else {
        indexPlayer = (indexPlayer - 1) % widget.players.length;
      }
      url = widget.players[indexPlayer].url!;
      title = widget.players[indexPlayer].title!;
      imageUrl = widget.players[indexPlayer].imageUrl!;
      slogan = widget.players[indexPlayer].slogan!;
      audioPlayer.setUrl(url);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.players[indexPlayer].title!),
        backgroundColor: const Color.fromARGB(255, 46, 9, 121),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 154, 161, 255),
              Color.fromARGB(255, 46, 9, 121),
            ],
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Card(
                  child: 
                    url != "" ?
                      RadioPlayer.withoutSeekBar(audioPlayer: audioPlayer, slogan: slogan, imageUrl: imageUrl, title: title, autoStart: false)
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
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () => changePlayer(false),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(const Color.fromARGB(255, 154, 161, 255),),
                          shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder()
                          ),
                        ),
                        child: const Icon(Icons.skip_previous, size: 30,),
                      ), 
                    ),
                  ),
                  Ink(
                    decoration: ShapeDecoration(
                      color: Colors.blueGrey[50],
                      shape: const CircleBorder()  
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () => changePlayer(true),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(const Color.fromARGB(255, 154, 161, 255),),
                          shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder()
                          ),
                        ),
                        child: const Icon(Icons.skip_next, size: 30,),
                      ), 
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