import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:spoticlone/models/radio_data.model.dart';

class RadioKingHttp {

  String urlAllRadios = "https://www.radioking.com/api/radio?limit=20&offset=0&order=rang&dir=asc&plateform=1";
  
  Future<List<RadioData>> getAllRadios() async {
    var response = await http.get(Uri.parse(urlAllRadios));
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<RadioData> radios = [];

    for (var radio in jsonResponse['data']) {
      radios.add(RadioData.fromJson(radio));
    }
    return radios;
  }

  String getRadioDataById() {
    return "";
  }


}