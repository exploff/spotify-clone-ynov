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
  final _storageService = StorageService();


  void downloadMusic() async { 
    setState(() {
      onDownload = true;
    });
    
    _storageService.startDownloading(widget.track);
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
                Text(widget.track.name!.length > 20 ? '${widget.track.name!.substring(0, 20)} ...' : widget.track.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white), ),
                Text('Artiste : ${widget.track.artistName!}', style: const TextStyle(fontSize: 12, color: Colors.white)),
              ],
            )
          ),
          widget.track.audio != "" ? Column(
            children: [
              IconButton(
                icon: 
                const Icon(Icons.download),
                color: const Color.fromARGB(255, 154, 161, 255),
                onPressed: () {
                  downloadMusic();
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _storageService.downloadNotifier,
                builder: (context, value, child) {
                  if (value) {
                    return Center(
                      child: SizedBox(
                        width: 80,
                        child: ValueListenableBuilder<double?>(
                          valueListenable: _storageService.progressNotifier,
                          builder: (context, percent, child) {
                            return LinearProgressIndicator(
                              value: percent,
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          )
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