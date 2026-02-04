import 'package:audio_player/services/eshei_audio_handler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // Instance of AudioHandler for managing audio playback
  final AudioHandler audioHandler;

  // Constructor to initialise with an instance of AudioHandler
  const HomePage({super.key, required this.audioHandler});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}