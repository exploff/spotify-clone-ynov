import 'package:spoticlone/models/radio_data.model.dart';

class PlayerData {
  String? url;
  String? imageUrl;
  String? title;
  String? metadataUrl;
  String? slogan;

  PlayerData(this.url, this.imageUrl, this.title, this.metadataUrl, this.slogan);


  PlayerData.fromRadioData(RadioData radioData) {
    url = "https://listen.radioking.com/radio/${radioData.idRadio}/stream/${radioData.idStream}";
    imageUrl = "https://www.radioking.com/api/track/cover/${radioData.idFileCover}?width=200&height=200";
    title = radioData.title.toString();
    slogan = radioData.slogan.toString();
    metadataUrl = "https://www.radioking.com/widgets/api/v1/radio/${radioData.idRadio}/track/current";
  }
        
}

