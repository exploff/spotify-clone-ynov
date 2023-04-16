import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spoticlone/models/album.mode.dart';
import 'package:spoticlone/models/track.model.dart';
import 'package:spoticlone/repository/http.jamendo.service.dart';
import 'package:spoticlone/components/track_preview.component.dart';
import 'package:spoticlone/views/search_music.view.dart';
import 'package:spoticlone/components/circular_progressor.component.dart';

class AlbumView extends StatefulWidget {
  final Album album;
  
  const AlbumView({required this.album, super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {

  List<Track> tracks = [];
  bool onSearch = true;

  @override
  void initState() {
    super.initState();
    JamendoHttp().getTracksFromAlbum(widget.album.id!).then(
      (value) {
        setState(() {
          tracks = value;
          onSearch = false;
        });
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.name!),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Card(
                child: 
                  widget.album.image != "" ? 
                    Image.network(widget.album.image!, fit: BoxFit.cover, width: 200, height: 200,) : 
                    const Placeholder(),
              ),
            ),
          ),
          Text(widget.album.name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(widget.album.artistName!, style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
          Expanded(
            child: 
              onSearch ?
              const CircularProgressorCustom() :
              tracks.isEmpty ?
              const Text('Aucun résultat') :
              ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              itemCount: tracks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (tracks[index].audio ==  "" || tracks[index].audio == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ce morceau n\'est pas disponible'),
                            backgroundColor: Colors.red,
                        )
                      );
                      } else {
                        Navigator.push(context,
                          MaterialPageRoute(  
                            builder: (BuildContext context) => SearchMusicView(song: tracks[index],)
                          )
                        );
                      }
                    },
                    child: TrackPreview(track: tracks[index])
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}