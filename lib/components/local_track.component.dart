import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:spoticlone/models/song_metadata.dart';

class LocalTrackPreview extends StatefulWidget {
  
  final SongMetadata songFile;
  
  const LocalTrackPreview({required this.songFile, super.key});

  @override
  State<LocalTrackPreview> createState() => _LocalTrackPreviewState();
}

class _LocalTrackPreviewState extends State<LocalTrackPreview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // return
    //   Center(
    //   child: Card(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ListTile(
    //           leading: const CircleAvatar(
    //             child: Icon(Icons.audiotrack)
    //           ),
    //           title: Text(widget.songFile.trackName!),
    //           subtitle: Text(widget.songFile.albumName??""),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Center(
      child: Row(
        children: [
          Container(
            height: 50,
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 209, 165, 215),
              child: Icon(Icons.audiotrack, color: Colors.white,),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(widget.songFile.trackName!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white), ),
                Text(widget.songFile.albumName??"", style: const TextStyle(fontSize: 10, color: Colors.white)),
              ],
            )
          ),
          Container(
            height: 50,
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 209, 165, 215),
              child: Icon(Icons.play_arrow, color: Colors.white,),
            ),
          ),
        ]
      ),
    );
  }
}