import 'package:flutter/material.dart';
import 'package:spoticlone/models/album.mode.dart';

class AlbumPreview extends StatefulWidget {
  final Album album;
  
  const AlbumPreview({required this.album, super.key});


  @override
  State<AlbumPreview> createState() => _AlbumPreviewState();
}

class _AlbumPreviewState extends State<AlbumPreview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      SizedBox(
        width: 250,
        height: 250,
        child: Image.network(widget.album.image!,),
      ),
      Container(
        //padding: const EdgeInsets.all(5.0),
        width: 250,
        height: 250,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.black.withAlpha(0),
              Colors.black12,
              Colors.black45
            ],
          ),
        ),
        child: Text(
          widget.album.name!.substring(0, widget.album.name!.length % 50),
          style: const TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}