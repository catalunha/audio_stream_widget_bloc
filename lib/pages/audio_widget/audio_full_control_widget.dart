import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class AudioWidgetControlWidget extends StatefulWidget {
  final AudioPlayer player;

  const AudioWidgetControlWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _AudioWidgetControlWidgetState();
  }
}

class _AudioWidgetControlWidgetState extends State<AudioWidgetControlWidget>
    with WidgetsBindingObserver {
  PlayerState? _playerState;
  Duration? _duration = Duration.zero;
  Duration? _position = Duration.zero;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _positionText =>
      _position?.toString().split('.').first ?? '0:00:00';
  String get _durationText =>
      _duration?.toString().split('.').first ?? '0:00:00';

  AudioPlayer get player => widget.player;
  double _speed = 1.00;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Use initial values from player
        _playerState = player.state;
        player.getCurrentPosition().then(
              (value) => setState(() {
                _position = value;
              }),
            );
        player.getDuration().then(
              (value) => setState(() {
                _duration = value;
              }),
            );
        _initStreams();
        WidgetsBinding.instance.addObserver(this);
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('*** *** AppLifecycleState :$state');
    if (AppLifecycleState.resumed != state) {
      log('--- --- AppLifecycleState :$state');
      _pause();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
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
    // if (_duration == null) {
    //   return const Center(child: LoadingLinearWidget());
    // }

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
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                // crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: _isPlaying ? false : true,
                    child: InkWell(
                      onTap: _isPlaying ? null : _play,
                      child: const Icon(Icons.play_arrow),
                    ),
                  ),
                  Visibility(
                    visible: _isPlaying ? true : false,
                    child: InkWell(
                      onTap: _isPlaying ? _pause : null,
                      child: const Icon(Icons.pause),
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Slider(
                          onChanged: (value) {
                            final duration = _duration;
                            if (duration == null) {
                              return;
                            }
                            final position = value * duration.inMilliseconds;
                            player
                                .seek(Duration(milliseconds: position.round()));
                          },
                          value: (_position != null &&
                                  _duration != null &&
                                  _position!.inMilliseconds > 0 &&
                                  _position!.inMilliseconds <
                                      _duration!.inMilliseconds)
                              ? _position!.inMilliseconds /
                                  _duration!.inMilliseconds
                              : 0.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '$_positionText / $_durationText',
                              style: Theme.of(context).textTheme.labelMedium,
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
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Visibility(
                            visible: player.playbackRate == 1.0 ? true : false,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _speed = 0.75;
                                });
                                await player.setPlaybackRate(_speed);
                              },
                              child: const Text('1.00x'),
                            ),
                          ),
                          Visibility(
                            visible: player.playbackRate == 0.75 ? true : false,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _speed = 0.5;
                                });
                                await player.setPlaybackRate(_speed);
                              },
                              child: const Text('0.75x'),
                            ),
                          ),
                          Visibility(
                            visible: player.playbackRate == 0.5 ? true : false,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _speed = 1;
                                });
                                await player.setPlaybackRate(_speed);
                              },
                              child: const Text('0.50x'),
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
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}
