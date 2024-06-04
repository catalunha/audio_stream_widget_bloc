// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_stream_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioStreamState {
  StateStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  AudioPlayer? get audioPlayer => throw _privateConstructorUsedError;
  PlayerState get playerState => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  Duration? get position => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioStreamStateCopyWith<AudioStreamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStreamStateCopyWith<$Res> {
  factory $AudioStreamStateCopyWith(
          AudioStreamState value, $Res Function(AudioStreamState) then) =
      _$AudioStreamStateCopyWithImpl<$Res, AudioStreamState>;
  @useResult
  $Res call(
      {StateStatus status,
      String? message,
      AudioPlayer? audioPlayer,
      PlayerState playerState,
      Duration? duration,
      Duration? position});
}

/// @nodoc
class _$AudioStreamStateCopyWithImpl<$Res, $Val extends AudioStreamState>
    implements $AudioStreamStateCopyWith<$Res> {
  _$AudioStreamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? audioPlayer = freezed,
    Object? playerState = null,
    Object? duration = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      audioPlayer: freezed == audioPlayer
          ? _value.audioPlayer
          : audioPlayer // ignore: cast_nullable_to_non_nullable
              as AudioPlayer?,
      playerState: null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioStreamStateImplCopyWith<$Res>
    implements $AudioStreamStateCopyWith<$Res> {
  factory _$$AudioStreamStateImplCopyWith(_$AudioStreamStateImpl value,
          $Res Function(_$AudioStreamStateImpl) then) =
      __$$AudioStreamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StateStatus status,
      String? message,
      AudioPlayer? audioPlayer,
      PlayerState playerState,
      Duration? duration,
      Duration? position});
}

/// @nodoc
class __$$AudioStreamStateImplCopyWithImpl<$Res>
    extends _$AudioStreamStateCopyWithImpl<$Res, _$AudioStreamStateImpl>
    implements _$$AudioStreamStateImplCopyWith<$Res> {
  __$$AudioStreamStateImplCopyWithImpl(_$AudioStreamStateImpl _value,
      $Res Function(_$AudioStreamStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? audioPlayer = freezed,
    Object? playerState = null,
    Object? duration = freezed,
    Object? position = freezed,
  }) {
    return _then(_$AudioStreamStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      audioPlayer: freezed == audioPlayer
          ? _value.audioPlayer
          : audioPlayer // ignore: cast_nullable_to_non_nullable
              as AudioPlayer?,
      playerState: null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$AudioStreamStateImpl implements _AudioStreamState {
  _$AudioStreamStateImpl(
      {this.status = StateStatus.data,
      this.message,
      this.audioPlayer,
      this.playerState = PlayerState.stopped,
      this.duration,
      this.position});

  @override
  @JsonKey()
  final StateStatus status;
  @override
  final String? message;
  @override
  final AudioPlayer? audioPlayer;
  @override
  @JsonKey()
  final PlayerState playerState;
  @override
  final Duration? duration;
  @override
  final Duration? position;

  @override
  String toString() {
    return 'AudioStreamState(status: $status, message: $message, audioPlayer: $audioPlayer, playerState: $playerState, duration: $duration, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioStreamStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.audioPlayer, audioPlayer) ||
                other.audioPlayer == audioPlayer) &&
            (identical(other.playerState, playerState) ||
                other.playerState == playerState) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, message, audioPlayer,
      playerState, duration, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioStreamStateImplCopyWith<_$AudioStreamStateImpl> get copyWith =>
      __$$AudioStreamStateImplCopyWithImpl<_$AudioStreamStateImpl>(
          this, _$identity);
}

abstract class _AudioStreamState implements AudioStreamState {
  factory _AudioStreamState(
      {final StateStatus status,
      final String? message,
      final AudioPlayer? audioPlayer,
      final PlayerState playerState,
      final Duration? duration,
      final Duration? position}) = _$AudioStreamStateImpl;

  @override
  StateStatus get status;
  @override
  String? get message;
  @override
  AudioPlayer? get audioPlayer;
  @override
  PlayerState get playerState;
  @override
  Duration? get duration;
  @override
  Duration? get position;
  @override
  @JsonKey(ignore: true)
  _$$AudioStreamStateImplCopyWith<_$AudioStreamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
