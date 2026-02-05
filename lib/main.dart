import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import 'package:audio_player/services/eshei_audio_handler.dart';
import 'package:audio_player/pages/playlist_page.dart';

// Instance of AudioHandler for global access
EsheiAudioHandler _audioHandler = EsheiAudioHandler(); 

// Main Function
Future<void> main() async {
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AudioService with AudioHandler as the audio handler
  _audioHandler = await AudioService.init(
    builder: () => EsheiAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.esheiplayer.example',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
    ),
  );

  // Run the application and set preferred orientations to portrait
  runApp(const MainApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      // Set the theme to dark
      theme: ThemeData.dark(), 
      
      // Set the home page to HomePage with the initialized audio handler
      home: PlaylistPage(audioHandler: _audioHandler),
    );
  }
}