import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import 'package:audio_player/services/eshei_audio_handler.dart';
import 'package:audio_player/pages/home_page.dart';

// Instance of AudioHandler for global access
EsheiAudioHandler _esheiAudioHandler = EsheiAudioHandler(); 

// Main Function
Future<void> main() async {
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AudioService with AudioHandler as the audio handler
  _esheiAudioHandler = await AudioService.init(
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
  Widget build()
}