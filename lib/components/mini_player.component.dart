import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
      child: Row(
        children: [
          const Icon(Icons.audiotrack),
          Center(
            child: Column(
              children: [
                Text(widget.title),
                Text(widget.slogan),
              ],
            ),
          ),
          const Icon(Icons.play_arrow),
          const Icon(Icons.skip_next)
        ],
      ),
    );
  }
}