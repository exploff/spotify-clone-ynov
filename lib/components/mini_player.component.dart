import 'package:flutter/material.dart';

class MiniPlayer extends StatefulWidget {
  final String title;
  final String slogan;
  const MiniPlayer({required this.title, required this.slogan, super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        
        color:Color.fromARGB(255, 154, 161, 255),
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.audiotrack, color: Colors.white),
            Container(
              child: Center(
                child: Text(widget.title),
              ),
            ),
            const Row(
              children: [
                Icon(Icons.skip_previous, color: Colors.white),
                Icon(Icons.play_arrow, color: Colors.white),
                Icon(Icons.skip_next, color: Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }
}