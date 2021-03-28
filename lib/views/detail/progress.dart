import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

class Progress extends StatefulWidget {
  final FlutterSoundPlayer player;
  final int duration;
  final Function(double) onChangeEnd;
  final bool loading;
  Progress({Key key, @required this.player, this.duration, this.onChangeEnd, this.loading}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  StreamSubscription subscription;

  double progress = 0.0;
  bool dragging = false;
  bool loading;
  @override
  void initState() {
    loading = widget.loading;

    subscription = widget.player.onProgress.listen((event) {
      if (widget.player.isPlaying == false || dragging || loading) return;

      setState(() => progress = event.position.inMilliseconds.toDouble());
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    subscription = null;

    super.dispose();
  }

  @override
  void didUpdateWidget(Progress oldWidget) {
    loading = widget.loading;
    if (loading) setState(() => progress = 0.0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      onChangeStart: (value) {
        setState(() {
          progress = value;
          dragging = true;
        });
      },
      onChanged: (value) {
        setState(() {
          progress = value;
        });
      },
      onChangeEnd: (value) {
        widget.onChangeEnd(value);

        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            dragging = false;
            progress = value;
          });
        });
      },
      min: 0.0,
      max: widget.duration.toDouble() ?? 0.0,
      value: dragging
          ? min(progress, widget.duration.toDouble())
          : loading
              ? 0.0
              : widget.duration == null || widget.duration == 0
                  ? 0.0
                  : min(progress, widget.duration.toDouble()),
    );
  }
}
