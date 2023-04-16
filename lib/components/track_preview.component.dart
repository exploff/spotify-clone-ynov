import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spoticlone/models/track.model.dart';
import 'package:spoticlone/repository/storage.service.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackPreview extends StatefulWidget {

  final Track track;
  
  const TrackPreview({required this.track, super.key});

  @override
  State<TrackPreview> createState() => _TrackPreviewState();
}

class _TrackPreviewState extends State<TrackPreview> {

  bool onDownload = false;

  void downloadMusic() async {

    if (await Permission.storage.request().isGranted) {
        
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
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Image.network(widget.track.image!,),
              ),
              title: Text(widget.track.name!),
              subtitle: Text('Artiste : ${widget.track.artistName!}'),
              
              trailing: 
                widget.track.audio != "" ? IconButton(
                  icon: onDownload ? const Icon(Icons.pending) : const Icon(Icons.download),
                  onPressed: () {
                    downloadMusic();
                  },)
                : const Icon(Icons.error),
            ),
          ],
        ),
      ),
    );;
  }
}