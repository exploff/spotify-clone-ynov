import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spoticlone/models/player_data.model.dart';

class RadioPreviewComponent extends StatefulWidget {

  final PlayerData playerData;

  const RadioPreviewComponent({required this.playerData, super.key});

  @override
  State<RadioPreviewComponent> createState() => _RadioPreviewComponentState();
}

class _RadioPreviewComponentState extends State<RadioPreviewComponent> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Card(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ListTile(
    //           leading: CircleAvatar(
    //             child: Image.network(widget.playerData.imageUrl!,),
    //           ),
    //           title: Text(widget.playerData.title!),
    //           subtitle: Text(widget.playerData.slogan!),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 211, 191, 255)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)
            ),
            child: Image.network(widget.playerData.imageUrl!, width: 75, height: 75,)
          ),
          Expanded(
            child: Column(
              children: [
                Text(widget.playerData.title!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white), ),
                Text(widget.playerData.slogan!.substring(0, widget.playerData.slogan!.length % 50), style: TextStyle(fontSize: 10, color: Colors.white)),
              ],
            )
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 211, 191, 255),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
              ),
              height: 75,
              child: const Icon(Icons.play_arrow, color: Colors.white)
            ),
          ),
        ],
      )
    );
  }
}