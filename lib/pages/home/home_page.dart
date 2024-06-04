import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:audio_stream_widget_bloc/pages/audio_bloc/audio_stream_page.dart';
import 'package:audio_stream_widget_bloc/pages/audio_widget/audio_full_control_widget.dart';
import 'package:audio_stream_widget_bloc/pages/audio_widget/audio_widget_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final player = AudioPlayer();
                await player.setSource(AssetSource('audios/audio1.mp3'));
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AudioWidgetPage(audioPlayer: player);
                  },
                ));
              },
              child: const Text('Audio Stream in Widget'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AudioStreamPage();
                  },
                ));
              },
              child: const Text('Audio Stream in BLoC'),
            )
          ],
        ),
      ),
    );
  }
}
