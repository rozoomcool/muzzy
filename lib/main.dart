import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:muzzy/service/song_handler.dart';

import 'app/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MyAudioHandler _songHandler = MyAudioHandler();
  _songHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.itabrek.muzzy',
      androidNotificationChannelName: 'Muzzy Player',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    ),
  );
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.itabrek.muzzy',
  //   androidNotificationChannelName: 'Muzzy playback',
  //   androidNotificationOngoing: true,
  // );

  GetIt.I.registerFactory(() => _songHandler);

  runApp(const MyApp());
}
