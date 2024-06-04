import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:audio_stream_widget_bloc/pages/audio_bloc/bloc/audio_stream_event.dart';
import 'package:audio_stream_widget_bloc/pages/audio_bloc/bloc/audio_stream_state.dart';
import 'package:audio_stream_widget_bloc/pages/shared/state_utilities.dart';

class AudioStreamBloc extends Bloc<AudioStreamEvent, AudioStreamState> {
  AudioStreamBloc()
      : super(
          AudioStreamState(
            audioPlayer: AudioPlayer(),
          ),
        ) {
    log(
      'constructor',
      name: runtimeType.toString(),
    );
    on<AudioStreamEventBibleStart>(_onAudioStreamEventBibleStart);
    on<AudioStreamEventPlay>(_onAudioStreamEventPlay);
    on<AudioStreamEventPause>(_onAudioStreamEventPause);
    on<AudioStreamEventStop>(_onAudioStreamEventStop);

    start();
  }
  void start() async {
    log(
      'start',
      name: runtimeType.toString(),
    );
    await state.audioPlayer
        ?.getCurrentPosition()
        .then((value) => emitSafe(state.copyWith(position: value)));
    await state.audioPlayer
        ?.getDuration()
        .then((value) => emitSafe(state.copyWith(duration: value)));
    startStreams();

    add(AudioStreamEventBibleStart());
  }

  late final StreamSubscription? _durationSubscription;
  late final StreamSubscription? _positionSubscription;
  late final StreamSubscription? _playerCompleteSubscription;
  late final StreamSubscription? _playerStateChangeSubscription;

  void startStreams() {
    log(
      'startStreams',
      name: runtimeType.toString(),
    );
    _durationSubscription =
        state.audioPlayer!.onDurationChanged.listen((value) {
      log('duration: $value');
      emitSafe(state.copyWith(duration: value));
    });
    _positionSubscription =
        state.audioPlayer!.onPositionChanged.listen((value) {
      log('position: $value');
      emitSafe(state.copyWith(position: value));
    });
    _playerCompleteSubscription = state.audioPlayer!.onPlayerComplete
        .listen((_) => emitSafe(state.copyWith(
              playerState: PlayerState.stopped,
              position: Duration.zero,
            )));
    _playerStateChangeSubscription = state.audioPlayer!.onPlayerStateChanged
        .listen((value) => emitSafe(state.copyWith(playerState: value)));
  }

  @override
  Future<void> close() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    state.audioPlayer?.dispose();
    return super.close();
  }

  FutureOr<void> _onAudioStreamEventBibleStart(
    AudioStreamEventBibleStart event,
    Emitter<AudioStreamState> emit,
  ) async {
    log(
      'bibleRecentGet()',
      name: runtimeType.toString(),
    );
    await state.audioPlayer?.dispose();
    emitSafe(
      state.copyWith(
        status: StateStatus.loading,
        audioPlayer: AudioPlayer(),
      ),
    );
    try {
      final AudioPlayer audioPlayer = AudioPlayer();

      await audioPlayer.setSource(AssetSource('audios/audio1.mp3'));
      await audioPlayer.setReleaseMode(ReleaseMode.stop);
      await audioPlayer.getDuration();
      await audioPlayer.getCurrentPosition();

      emitSafe(
        state.copyWith(
          status: StateStatus.data,
          audioPlayer: audioPlayer,
        ),
      );
    } catch (e) {
      log(
        'bibleRecentGet. Error',
        name: runtimeType.toString(),
      );

      emitSafe(
        state.copyWith(
          status: StateStatus.error,
          message: 'Error in VersesCubit.bibleRecentGet',
        ),
      );
    }
  }

  FutureOr<void> _onAudioStreamEventPlay(
    AudioStreamEventPlay event,
    Emitter<AudioStreamState> emit,
  ) async {
    state.audioPlayer!.resume();
    emitSafe(state.copyWith(playerState: PlayerState.playing));
  }

  FutureOr<void> _onAudioStreamEventPause(
    AudioStreamEventPause event,
    Emitter<AudioStreamState> emit,
  ) async {
    state.audioPlayer!.pause();
    emitSafe(state.copyWith(playerState: PlayerState.paused));
  }

  FutureOr<void> _onAudioStreamEventStop(
    AudioStreamEventStop event,
    Emitter<AudioStreamState> emit,
  ) async {
    state.audioPlayer!.stop();
    emitSafe(state.copyWith(
      playerState: PlayerState.stopped,
      position: Duration.zero,
    ));
  }
}
