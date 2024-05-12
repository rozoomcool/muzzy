import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muzzy/domain/audios_bloc/audios_state.dart';
import 'package:muzzy/service/get_songs.dart';
import 'package:muzzy/service/song_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(InitialAudioState());

  final songHandler = GetIt.I<MyAudioHandler>();

  void init() {
    // Future.sync(() => requestPermissions());
    getAudio();
  }

  void getAudio() async {
    var _songs = await getSongs();
    songHandler.initSongs(songs: _songs);
    emit(LoadedAudioState(songs: _songs));
  }
}
