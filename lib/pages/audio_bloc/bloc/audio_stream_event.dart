import 'package:equatable/equatable.dart';

abstract class AudioStreamEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AudioStreamEventBibleStart extends AudioStreamEvent {}

class AudioStreamEventPosition extends AudioStreamEvent {
  final Duration? duration;

  AudioStreamEventPosition(this.duration);
}

class AudioStreamEventSeek extends AudioStreamEvent {
  final Duration? duration;

  AudioStreamEventSeek(this.duration);
}

class AudioStreamEventPlay extends AudioStreamEvent {}

class AudioStreamEventPause extends AudioStreamEvent {}

class AudioStreamEventStop extends AudioStreamEvent {}
