class Album {

 String? id;
  String? name;
  String? releasedate;
  String? artistId;
  String? artistName;
  String? image;
  String? zip;
  String? shorturl;
  String? shareurl;
  bool? zipAllowed;

  Album(
      {this.id,
      this.name,
      this.releasedate,
      this.artistId,
      this.artistName,
      this.image,
      this.zip,
      this.shorturl,
      this.shareurl,
      this.zipAllowed});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    releasedate = json['releasedate'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
    image = json['image'];
    zip = json['zip'];
    shorturl = json['shorturl'];
    shareurl = json['shareurl'];
    zipAllowed = json['zip_allowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['releasedate'] = this.releasedate;
    data['artist_id'] = this.artistId;
    data['artist_name'] = this.artistName;
    data['image'] = this.image;
    data['zip'] = this.zip;
    data['shorturl'] = this.shorturl;
    data['shareurl'] = this.shareurl;
    data['zip_allowed'] = this.zipAllowed;
    return data;
  }

}