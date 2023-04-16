class RadioData {
  String? title;
  String? idFileCover;
  String? slogan;
  int? idRadio;
  int? idStream;

  RadioData(this.title, this.idFileCover, this.idRadio, this.idStream, this.slogan);

  RadioData.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    idFileCover = json['idfile_logo'];
    idRadio = json['streams'][0]['idradio'];
    idStream = json['streams'][0]['idstream'];
    slogan = json['slogan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['idFileCover'] = this.idFileCover;
    data['idRadio'] = this.idRadio;
    data['idStream'] = this.idStream;
    data['slogan'] = this.slogan;
    return data;
  }
}