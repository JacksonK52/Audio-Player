
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  final AudioHandler audioHandler;

  const PlayerPage({super.key, required this.audioHandler});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('P L A Y I N G'),),
    );
  }
}