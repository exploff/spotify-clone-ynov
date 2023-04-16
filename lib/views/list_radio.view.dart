import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spoticlone/components/circular_progressor.component.dart';
import 'package:spoticlone/components/radio_preview.component.dart';
import 'package:spoticlone/models/player_data.model.dart';
import 'package:spoticlone/models/radio_data.model.dart';
import 'package:spoticlone/repository/http.radioking.service.dart';
import 'package:spoticlone/views/radio.view.dart';

class ListRadioView extends StatefulWidget {
  const ListRadioView({super.key});

  @override
  State<ListRadioView> createState() => _ListRadioViewState();
}

class _ListRadioViewState extends State<ListRadioView> {

  String url = "";
  String title = "";
  String imageUrl = "";
  int indexPlayer = 0;
  bool loader = true;

  @override
  void initState() {
    super.initState();

    RadioKingHttp().getAllRadios().then((value) { 
      setState(() {
        for (RadioData radio in value) {
          players.add(
            PlayerData.fromRadioData(radio)
          );
        }
        loader = false;
      });
    });
  }

  @override 
  void dispose() {
    super.dispose();
  }

  List<PlayerData> players = [];

  @override
  Widget build(BuildContext context) {
    return loader ? 
    const CircularProgressorCustom() :
    Center(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: players.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(  
                    builder: (BuildContext context) => RadioView(players: players, indexPlayer: index,)
                  )
                );
              },
              child: RadioPreviewComponent(playerData: players[index],)
            ),
          );
        }
      ),
    );
  }
}
