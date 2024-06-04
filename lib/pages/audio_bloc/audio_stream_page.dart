import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:audio_stream_widget_bloc/pages/audio_bloc/audio_stream_control_widget.dart';
import 'package:audio_stream_widget_bloc/pages/audio_widget/audio_full_control_widget.dart';

class AudioStreamPage extends StatelessWidget {
  const AudioStreamPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio with Stream in bloc'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AudioStreamControlWidget(),
          ],
        ),
      ),
    );
  }
}
