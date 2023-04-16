import 'package:spoticlone/models/album.mode.dart';
import 'package:spoticlone/models/track.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert' show utf8;

class JamendoHttp {

  String mainUrl = "https://api.jamendo.com/v3.0";

  String trackFromAlbumId = "/tracks/?client_id=2006268e&format=jsonpretty&speed=high+veryhigh";
  
  String albumsUrl = "/albums?client_id=2006268e&format=jsonpretty&include=tracks";

  String getSearchUrl(String key, [int limit = 10, int offset = 0]) {
    return "/tracks?client_id=2006268e&format=jsonpretty&limit=$limit&search=$key&speed=high+veryhigh";
  }

  Future<List<Album>> getAlbums([int limit = 10, int offset = 0]) async {
    
    var response = await http.get(Uri.parse(mainUrl + albumsUrl));
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<Album> albums = [];

    for (var album in jsonResponse['results']) {
      albums.add(Album.fromJson(album));
    }
    return albums;
  }

  Future<List<Track>> getTracksFromAlbum(String albumId) async {
    print("Url : $mainUrl$trackFromAlbumId&album_id=$albumId");
    var response = await http.get(Uri.parse("$mainUrl$trackFromAlbumId&album_id=$albumId"));
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<Track> tracks = [];

    for (var track in jsonResponse['results']) {
      tracks.add(Track.fromJson(track));
    }
    print(tracks);
    return tracks;
  }

  Future<List<Track>> searchTrack(String key, [int limit = 10, int offset = 0]) async {
      if (key.isEmpty || key.length < 3) return Future.value([]);

      key = Uri.encodeFull(key);
      var url = Uri.parse(mainUrl + getSearchUrl(key, limit, offset));

      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      List<Track> tracks = [];
  
      for (var track in jsonResponse['results']) {
        tracks.add(Track.fromJson(track));
      }
      return tracks;

  }

}