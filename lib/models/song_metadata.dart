class SongMetadata {
  String? trackName;
  List<String>? trackArtistNames;
  String? albumName;
  String? albumArtistName;
  int? trackNumber;
  String? authorName;
  String? mimeType;
  int? trackDuration;
  int? bitrate;
  String? filePath;
  String? uri;

  SongMetadata(
      {this.trackName,
      this.trackArtistNames,
      this.albumName,
      this.albumArtistName,
      this.trackNumber,
      this.authorName,
      this.mimeType,
      this.trackDuration,
      this.bitrate,
      this.filePath});

  SongMetadata.fromJson(Map<String, dynamic> json) {
    trackName = json['trackName'];
    trackArtistNames = json['trackArtistNames'].cast<String>();
    albumName = json['albumName'];
    albumArtistName = json['albumArtistName'];
    trackNumber = json['trackNumber'];
    authorName = json['authorName'];
    mimeType = json['mimeType'];
    trackDuration = json['trackDuration'];
    bitrate = json['bitrate'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trackName'] = this.trackName;
    data['trackArtistNames'] = this.trackArtistNames;
    data['albumName'] = this.albumName;
    data['albumArtistName'] = this.albumArtistName;
    data['trackNumber'] = this.trackNumber;
    data['authorName'] = this.authorName;
    data['mimeType'] = this.mimeType;
    data['trackDuration'] = this.trackDuration;
    data['bitrate'] = this.bitrate;
    data['filePath'] = this.filePath;
    data['uri'] = this.uri;
    return data;
  }
}