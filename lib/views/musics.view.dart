import 'dart:io';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:spoticlone/components/circular_progressor.component.dart';
import 'package:spoticlone/components/mini_player.component.dart';
import 'package:spoticlone/models/song_metadata.dart';
import 'package:spoticlone/repository/storage.service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spoticlone/components/local_track.component.dart';
import 'package:spoticlone/views/music.view.dart';

class MusicsView extends StatefulWidget {
  const MusicsView({super.key});

  @override
  State<MusicsView> createState() => _MusicsViewState();
}

class _MusicsViewState extends State<MusicsView> {

  List<SongMetadata> musicsMetadata = [];

  bool loader = true;

  String musicName = "";

  // TODO : MUSICS LISTES ON AUDIO QUERY
  // TODO : RECUPERER LES MUSICS DEPUIS STORAGE DYNAMIQUEMENT

  void getLocalMusics() async {

    print("getLocalMusics");
    if (await Permission.storage.request().isGranted) {
      StorageService().getLocalMusics().then((songs) {
        setState(() {
          if (songs.isNotEmpty) {
              musicsMetadata = songs;
          }
          loader = false;
        });
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();

    getLocalMusics();
  }

  @override
  Widget build(BuildContext context) {
    return loader ? 
    const CircularProgressorCustom() :
    musicsMetadata.isEmpty ?
    const Center(child: Text('Aucune musique trouvée')) :
    Column(
      children: [
        Expanded(
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: musicsMetadata.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      var result = Navigator.push(context,
                        MaterialPageRoute(  
                          builder: (BuildContext context) => MusicView(players: musicsMetadata, indexPlayer: index,)
                        )
                      );
                      result.then((value) {
                        if (value != null) {
                          setState(() {
                            musicName = value;
                          });
                          //TODO : AFFICHER LE LECTEUR EN BAS DE L ECRAN
                          print(value);                  
                        }
                      });
                    },
                    child: Column(
                      children: [
                        LocalTrackPreview(songFile: musicsMetadata[index],),
                        index < musicsMetadata.length - 1 ?
                         Divider(color: Colors.white, height: 25, thickness: 1,):
                          Container()
                      ],
                    )
                  ),
                );
              }
            ),
           
          ),
        ),
        musicName != "" ?
        MiniPlayer(title: musicName, slogan: "") :
        Container()
      ],
    );
  }
}