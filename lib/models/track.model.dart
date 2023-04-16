class Track {
  String? id;
  String? name;
  int? duration;
  String? artistId;
  String? artistName;
  String? artistIdstr;
  String? albumName;
  String? albumId;
  String? releasedate;
  String? albumImage;
  String? audio;
  String? audiodownload;
  String? shorturl;
  String? image;

  Track(
      {this.id,
      this.name,
      this.duration,
      this.artistId,
      this.artistName,
      this.artistIdstr,
      this.albumName,
      this.albumId,
      this.releasedate,
      this.albumImage,
      this.audio,
      this.audiodownload,
      this.shorturl,
      this.image});

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    duration =json['duration'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
    artistIdstr = json['artist_idstr'];
    albumName = json['album_name'];
    albumId = json['album_id'];
    releasedate = json['releasedate'];
    albumImage = json['album_image'];
    audio = json['audio'];
    audiodownload = json['audiodownload'];
    shorturl = json['shorturl'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['artist_id'] = this.artistId;
    data['artist_name'] = this.artistName;
    data['artist_idstr'] = this.artistIdstr;
    data['album_name'] = this.albumName;
    data['album_id'] = this.albumId;
    data['releasedate'] = this.releasedate;
    data['album_image'] = this.albumImage;
    data['audio'] = this.audio;
    data['audiodownload'] = this.audiodownload;
    data['shorturl'] = this.shorturl;
    data['image'] = this.image;
    return data;
  }
}
