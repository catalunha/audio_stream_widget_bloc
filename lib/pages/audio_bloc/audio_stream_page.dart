import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:audio_stream_widget_bloc/pages/audio_bloc/audio_stream_control_join_widget.dart';
import 'package:audio_stream_widget_bloc/pages/audio_bloc/audio_stream_control_widget.dart';
import 'package:audio_stream_widget_bloc/pages/audio_bloc/bloc/audio_stream_bloc.dart';

class AudioStreamPage extends StatelessWidget {
  const AudioStreamPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioStreamBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Audio with Stream in bloc'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AudioStreamControlWidget(),
              AudioStreamControlJoinWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
