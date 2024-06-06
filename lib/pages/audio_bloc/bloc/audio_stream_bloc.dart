import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    on<AudioStreamEventBibleStart>(_onAudioStreamEventBibleStart,
        transformer: concurrent());
    on<AudioStreamEventPlay>(_onAudioStreamEventPlay,
        transformer: concurrent());
    on<AudioStreamEventPause>(_onAudioStreamEventPause);
    on<AudioStreamEventStop>(_onAudioStreamEventStop);
    on<AudioStreamEventSeek>(_onAudioStreamEventSeek);

    start();
  }
  void start() async {
    log(
      'start',
      name: runtimeType.toString(),
    );
    add(AudioStreamEventBibleStart());
  }

  @override
  Future<void> close() {
    state.audioPlayer?.dispose();
    return super.close();
  }

  FutureOr<void> _onAudioStreamEventBibleStart(
    AudioStreamEventBibleStart event,
    Emitter<AudioStreamState> emit,
  ) async {
    log(
      'AudioStreamEventBibleStart()',
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
      Duration? duration = await audioPlayer.getDuration();
      Duration? position = await audioPlayer.getCurrentPosition();
      // await emit.forEach<void>(
      //   state.audioPlayer!.onPlayerComplete,
      //   onData: (_) => state.copyWith(
      //       position: Duration.zero, playerState: PlayerState.stopped),
      // );
      emitSafe(state.copyWith(
        status: StateStatus.data,
        audioPlayer: audioPlayer,
        position: position,
        duration: duration,
      ));
      log(
        'AudioStreamEventBibleStart. end',
        name: runtimeType.toString(),
      );
    } catch (e) {
      log(
        'AudioStreamEventBibleStart. Error',
        name: runtimeType.toString(),
      );

      emitSafe(
        state.copyWith(
          status: StateStatus.error,
          message: 'Error in AudioStreamEventBibleStart',
        ),
      );
    }
  }

  FutureOr<void> _onAudioStreamEventSeek(
    AudioStreamEventSeek event,
    Emitter<AudioStreamState> emit,
  ) async {
    log('seeeeek');
    await state.audioPlayer!.seek(event.duration!);
  }

  FutureOr<void> _onAudioStreamEventPlay(
    AudioStreamEventPlay event,
    Emitter<AudioStreamState> emit,
  ) async {
    log('playyyyyyyyyyyyyyyyy');

    await state.audioPlayer!.resume();
    emitSafe(state.copyWith(playerState: PlayerState.playing));

    await emit.forEach<Duration>(
      state.audioPlayer!.onPositionChanged,
      onData: (value) => state.copyWith(position: value),
    );
  }

  FutureOr<void> _onAudioStreamEventPause(
    AudioStreamEventPause event,
    Emitter<AudioStreamState> emit,
  ) async {
    log('paaaaaaaaaaaaaaaaaaause');
    await state.audioPlayer!.pause();
    emitSafe(state.copyWith(playerState: PlayerState.paused));
    log('paaaaaaaaaaaaaaaaaaause.....${state.playerState}');
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
