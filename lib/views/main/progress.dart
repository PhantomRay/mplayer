import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Progress extends StatefulWidget {
  final FlutterSoundPlayer player;
  final int duration;

  Progress({Key key, @required this.player, this.duration}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  StreamSubscription subscription;

  int progress = 0;

  @override
  void initState() {
    subscription = widget.player.onProgress.listen((event) {
      if (widget.player.isPlaying == false) return;

      setState(() => progress = event.position.inMilliseconds);
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    subscription = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      lineHeight: 2.0,
      percent: widget.duration == null || widget.duration == 0 ? 0.0 : progress / widget.duration,
      progressColor: Colors.blue,
      backgroundColor: Color(0xffeeeeee).withOpacity(0.95),
    );
  }
}
