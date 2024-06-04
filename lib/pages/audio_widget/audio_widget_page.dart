import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:audio_stream_widget_bloc/pages/audio_widget/audio_full_control_widget.dart';

class AudioWidgetPage extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const AudioWidgetPage({
    super.key,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio with Stream in widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AudioWidgetControlWidget(player: audioPlayer),
          ],
        ),
      ),
    );
  }
}
