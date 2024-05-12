import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../model/audio_model.dart';

abstract class AudioState{}
class InitialAudioState extends AudioState{}
class LoadedAudioState extends AudioState{
  final List<MediaItem> songs;
  LoadedAudioState({required this.songs});
}
class NotLoadedAudioState extends AudioState{}