import 'package:flutter/material.dart';
import 'package:spoticlone/models/track.model.dart';
import 'package:spoticlone/repository/storage.service.dart';

class TrackPreview extends StatefulWidget {

  final Track track;
  
  const TrackPreview({required this.track, super.key});

  @override
  State<TrackPreview> createState() => _TrackPreviewState();
}

class _TrackPreviewState extends State<TrackPreview> {

  bool onDownload = false;

  void downloadMusic() async {
    //if (await Permission.storage.request().isGranted) {
        
      if (onDownload) return;

      setState(() {
        onDownload = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Téléchargement en cours'),
          backgroundColor: Colors.amber,
        )
      ); 

      StorageService().downloadMusic(widget.track).then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value ? 'Téléchargement réussi' : 'Téléchargement échoué'),
              backgroundColor: value ? Colors.green : Colors.red,
            )
          );
          setState(() {
            onDownload = false;
          });  
        }
      );
    // } else if (await Permission.storage.request().isPermanentlyDenied) {
    //   await openAppSettings();
    // } else if (await Permission.storage.request().isDenied) {
    //   await Permission.storage.request();
    // }
  }

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Row(
        children: [
          Container(
            height: 50,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 209, 165, 215),
              child: Image.network(widget.track.image!,),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(widget.track.name!.length > 20 ? '${widget.track.name!.substring(0, 20)} ...' : widget.track.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white), ),
                Text('Artiste : ${widget.track.artistName!}', style: const TextStyle(fontSize: 10, color: Colors.white)),
              ],
            )
          ),
          widget.track.audio != "" ? IconButton(
            icon: onDownload ? const Icon(Icons.pending) : const Icon(Icons.download),
            color: Color.fromARGB(255, 154, 161, 255),
            onPressed: () {
              downloadMusic();
            },)
          : IconButton(
            icon: const Icon(Icons.error, color: Color.fromARGB(255, 154, 161, 255),),
            onPressed: () {
            }
          ),
        ]
      ),
    );
  }
}