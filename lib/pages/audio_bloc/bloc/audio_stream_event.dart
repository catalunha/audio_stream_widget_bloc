import 'package:equatable/equatable.dart';

abstract class AudioStreamEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AudioStreamEventBibleStart extends AudioStreamEvent {}

class AudioStreamEventPlay extends AudioStreamEvent {}

class AudioStreamEventPause extends AudioStreamEvent {}

class AudioStreamEventStop extends AudioStreamEvent {}
