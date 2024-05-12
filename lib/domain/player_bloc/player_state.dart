import 'package:audio_service/audio_service.dart';

abstract class AppPlayerState {}

class EmptyPlayerState extends AppPlayerState {}
abstract class NonEmptyPlayerState extends AppPlayerState{
  MediaItem get item;
}

class PlayedPlayerState extends NonEmptyPlayerState {

  MediaItem item;

  PlayedPlayerState(this.item);
}

class PausedPlayerState extends NonEmptyPlayerState {
  MediaItem item;

  PausedPlayerState(this.item);
}