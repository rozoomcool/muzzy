import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muzzy/domain/player_bloc/player_state.dart';
import 'package:muzzy/service/song_handler.dart';

class PlayerCubit extends Cubit<AppPlayerState> {
  PlayerCubit() : super(EmptyPlayerState());

  final AudioPlayer player = AudioPlayer();
  final MyAudioHandler audioHandler = GetIt.I<MyAudioHandler>();

  void playAudioSource(MediaItem item) async {
    await audioHandler.stop();
    await audioHandler.playMediaItem(item);
    await audioHandler.addQueueItem(item);
    emit(PlayedPlayerState(item));
    play();
  }

  void play() async {
    if (state is NonEmptyPlayerState) {
      emit(PlayedPlayerState((state as NonEmptyPlayerState).item));

    }
    await audioHandler.play();
  }

  void stop() async {
    if (state is NonEmptyPlayerState) {
      emit(PausedPlayerState((state as NonEmptyPlayerState).item));
    }
    await audioHandler.stop();
  }

}