import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:spoticlone/models/song_metadata.dart';
import 'package:spoticlone/models/track.model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class StorageService {
  
  String storageDir = '/sdcard/download/spoticlone';


  Future<bool> downloadMusic(Track track) async {

    try {
      Directory dir = Directory(storageDir);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      var fileName = track.name ?? "unknown _${DateTime.now()}";

      String filePath = '$storageDir/${fileName}.mp3';
      
      http.Response response = await http.get(Uri.parse(track.audio!));
      File file = File(filePath);
      file.writeAsBytesSync(response.bodyBytes);
      return true;
    } catch (e) {
      print("LOG : $e");
      return false;
    }
  }

  Future<List<SongMetadata>> getLocalMusics() async {

      Directory dir = Directory(storageDir);
      if (!dir.existsSync()) {
        return [];
      }
      List<FileSystemEntity> files = dir.listSync(recursive: false, followLinks: false);
      List<SongMetadata> songs = [];
      for (FileSystemEntity file in files) {
        if (file.path.endsWith(".mp3")) {
          final metadata = await MetadataRetriever.fromFile(File(file.path));
          SongMetadata songMetadata = SongMetadata.fromJson(metadata.toJson());  
          songMetadata.uri = file.uri.toString();
          songs.add(songMetadata);
        }
      }
      return songs;
  }
}