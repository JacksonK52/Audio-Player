import 'package:audio_player/services/eshei_audio_handler.dart';
import 'package:audio_player/widgets/song_widget.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/services/fetch_songs.dart';

class PlaylistPage extends StatefulWidget {
  // Instance of AudioHandler for managing audio playback
  final EsheiAudioHandler audioHandler;

  // Constructor to initialise with an instance of AudioHandler
  const PlaylistPage({super.key, required this.audioHandler});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  // List to store MediaItems representing songs
  List<MediaItem> songs = [];

  @override
  void initState() {
    // Execute FetchSongs to retreive and set the list of songs
    FetchSongs.execute().then((value) {
      setState(() {
        songs = value;
      });

      // Initialize songs in the audio handler
      widget.audioHandler.initSongs(songs: value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("P L A Y L I S T")),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          MediaItem item = songs[index];
          return SongWidget(audioHandler: widget.audioHandler, item: item, index: index);
        },
      ),
    );
  }
}
