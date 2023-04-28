import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:spoticlone/models/song_metadata.dart';
import 'package:spoticlone/models/track.model.dart';

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

  final progressNotifier = ValueNotifier<double?>(0);
  final downloadNotifier = ValueNotifier<bool>(false);

  void startDownloading(Track track) async {
    progressNotifier.value = null;
    downloadNotifier.value = true;

    var url = track.audio!;
    final request = http.Request('GET', Uri.parse(url));
    final http.StreamedResponse response = await http.Client().send(request);

    final contentLength = response.contentLength;
    // final contentLength = double.parse(response.headers['x-decompressed-content-length']);

    progressNotifier.value = 0;

    List<int> bytes = [];
    var fileName = track.name ?? "unknown _${DateTime.now()}";
    String filePath = '$storageDir/${fileName}.mp3';
    File file = File(filePath);

    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        progressNotifier.value = downloadedLength / contentLength!;
      },
      onDone: () async {
        progressNotifier.value = 0;
        await file.writeAsBytes(bytes);
        downloadNotifier.value = false;
      },
      onError: (e) {
        debugPrint(e);
      },
      cancelOnError: true,
    );
  }

  void saveMusic(List<int> bytes, Track track) {
      Directory dir = Directory(storageDir);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      var fileName = track.name ?? "unknown _${DateTime.now()}";

      String filePath = '$storageDir/${fileName}.mp3';
      
      File file = File(filePath);
      file.writeAsBytesSync(bytes);
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