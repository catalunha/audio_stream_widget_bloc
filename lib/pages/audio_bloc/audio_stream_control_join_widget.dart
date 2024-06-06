import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:audio_stream_widget_bloc/pages/audio_bloc/bloc/audio_stream_bloc.dart';
import 'package:audio_stream_widget_bloc/pages/audio_bloc/bloc/audio_stream_event.dart';
import 'package:audio_stream_widget_bloc/pages/audio_bloc/bloc/audio_stream_state.dart';

class AudioStreamControlJoinWidget extends StatefulWidget {
  const AudioStreamControlJoinWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _AudioStreamControlJoinWidgetState();
  }
}

class _AudioStreamControlJoinWidgetState
    extends State<AudioStreamControlJoinWidget> with WidgetsBindingObserver {
  double _speed = 1.00;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('*** *** AppLifecycleState :$state');
    if (AppLifecycleState.resumed != state) {
      log('--- --- AppLifecycleState :$state');
      // _pause();
      context.read<AudioStreamBloc>().add(AudioStreamEventPause());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    log(
      'build',
      name: runtimeType.toString(),
    );
    return BlocBuilder<AudioStreamBloc, AudioStreamState>(
      builder: (context, state) {
        log(
          'state.position: ${state.position}',
          name: runtimeType.toString(),
        );
        if (state.duration == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(17.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
                      Visibility(
                        visible: state.playerState == PlayerState.playing
                            ? false
                            : true,
                        child: InkWell(
                          onTap: state.playerState == PlayerState.playing
                              ? null
                              : () => context
                                  .read<AudioStreamBloc>()
                                  .add(AudioStreamEventPlay()),
                          child: const Icon(Icons.play_arrow),
                        ),
                      ),
                      Visibility(
                        visible: state.playerState == PlayerState.playing
                            ? true
                            : false,
                        child: InkWell(
                          onTap: state.playerState == PlayerState.playing
                              ? () => context
                                  .read<AudioStreamBloc>()
                                  .add(AudioStreamEventPause())
                              : null,
                          child: const Icon(Icons.pause),
                        ),
                      ),
                      Flexible(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Slider(
                              thumbColor: Colors.green,
                              onChanged: (value) {
                                final duration = state.duration;
                                if (duration == null) {
                                  return;
                                }
                                final position =
                                    value * duration.inMilliseconds;
                                context.read<AudioStreamBloc>().add(
                                    AudioStreamEventSeek(Duration(
                                        milliseconds: position.round())));
                              },
                              value: (state.position != null &&
                                      state.duration != null &&
                                      state.position!.inMilliseconds > 0 &&
                                      state.position!.inMilliseconds <
                                          state.duration!.inMilliseconds)
                                  ? state.position!.inMilliseconds /
                                      state.duration!.inMilliseconds
                                  : 0.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${state.position} / ${state.duration}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Visibility(
                                visible: state.audioPlayer!.playbackRate == 1.0
                                    ? true
                                    : false,
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _speed = 0.5;
                                    });
                                    await state.audioPlayer!
                                        .setPlaybackRate(_speed);
                                  },
                                  child: const Text('1.0x'),
                                ),
                              ),
                              Visibility(
                                visible: state.audioPlayer!.playbackRate != 1.0
                                    ? true
                                    : false,
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _speed = 1;
                                    });
                                    await state.audioPlayer!
                                        .setPlaybackRate(_speed);
                                  },
                                  child: const Text('0.5x'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
