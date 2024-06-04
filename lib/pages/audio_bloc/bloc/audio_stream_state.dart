import 'package:audioplayers/audioplayers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:audio_stream_widget_bloc/pages/shared/state_utilities.dart';

part 'audio_stream_state.freezed.dart';

@freezed
class AudioStreamState with _$AudioStreamState {
  factory AudioStreamState({
    @Default(StateStatus.data) StateStatus status,
    String? message,
    AudioPlayer? audioPlayer,
    @Default(PlayerState.stopped) PlayerState playerState,
    Duration? duration,
    Duration? position,
  }) = _AudioStreamState;
}
