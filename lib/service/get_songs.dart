import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:muzzy/service/request_song_permission.dart';
import 'package:muzzy/service/song_to_media_item.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<List<MediaItem>> getSongs() async {
  try {
    await requestSongPermission();
    final List<MediaItem> songs = [];
    final OnAudioQuery onAudioQuery = OnAudioQuery();
    final List<SongModel> songModels = await onAudioQuery.querySongs();
    for (final SongModel songModel in songModels) {
      if (songModel.title.contains("AUD")) continue;
      final MediaItem song = await songToMediaItem(songModel);
      songs.add(song);
    }
    print("::::::::::::${songs.length}");
    return songs;
  } catch (e) {
    debugPrint('Error fetching songs: $e');
    return [];
  }
}