import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();

  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  // Listen for changes in the current song index and update the media item
  void _listenForCurrentSongIndexChanges() {
    _player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }

  // Broadcast the current playback state based on the received PlaybackEvent
  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }

  Future<void> initSongs({required List<MediaItem> songs}) async {
    _player.playbackEventStream.listen(_broadcastState);

    final audioSource = songs.map(_createAudioSource).toList();

    await _player
        .setAudioSource(ConcatenatingAudioSource(children: audioSource));

    queue.value.clear();
    queue.value.addAll(songs);
    queue.add(queue.value);

    _listenForCurrentSongIndexChanges();

    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) skipToNext();
    });
  }


  @override
  Future<Duration?> playMediaItem(MediaItem mediaItem) {
    AudioSource source = _createAudioSource(mediaItem);
    return _player.setAudioSource(source);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToQueueItem(int i) => _player.seek(Duration.zero, index: i);
}
