import 'dart:convert';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

// Instance of OnAudioQuery to query songs from device storage
OnAudioQuery onAudioQuery = OnAudioQuery();

// Function to request storage permission
Future<void> accessStorage() async =>
    await Permission.storage.status.isGranted.then((granted) async {
      if (granted == false) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.permanentlyDenied) {
          await openAppSettings();
        }
      }
    });

// Function to retreived artwork for a given song ID
Future<Uint8List?> art({required int id}) async {
  return await onAudioQuery.queryArtwork(id, ArtworkType.AUDIO, quality: 100);
}

// Function to convert Uint8List to Base64 String
Future<Uint8List?> toImage({required Uri uri}) async {
  return base64.decode(uri.data!.toString().split(',').last);
}

// Class to fetch songs from device storage and convert them to MediaItem format
class FetchSongs {
  // Static Method to execute fetching songs asynchronously
  static Future<List<MediaItem>> execute() async {
    // Initialize an empty list to store MediaItems
    List<MediaItem> items = [];

    // Ensure storage permission is granted before proceeding
    await accessStorage().then((_) async {
      // Queue songs using OnAudioQuery
      List<SongModel> songs = await onAudioQuery.querySongs();

      // Loop through the retreived songs and convert them to MediaItem
      for (SongModel song in songs) {
        if (song.isMusic == true) {
          // Retreived artwork for the song
          Uint8List? artwork = await art(id: song.id);
          List<int> bytes = [];
          if (artwork != null) {
            bytes = artwork.toList();
          }

          // Add the converted song to the list of MediaItems
          items.add(
            MediaItem(
              id: song.uri!,
              title: song.title,
              artist: song.artist ?? 'Unknown',
              duration: Duration(milliseconds: song.duration!),
              artUri: artwork == null ? null : Uri.dataFromBytes(bytes),
            ),
          );
        }
      }
    });
    return items;
  }
}
