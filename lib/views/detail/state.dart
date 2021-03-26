import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:player/models/music_model.dart';

class DetailPageState implements Cloneable<DetailPageState> {
  FlutterSoundPlayer player;
  MusicModel detail;
  bool isPlaying;
  int duration;
  int progress;
  StreamSubscription subScriptionProgress;
  bool dragging;
  List<MusicModel> musics;

  @override
  DetailPageState clone() {
    return DetailPageState()
      ..player = player
      ..detail = detail
      ..isPlaying = isPlaying
      ..progress = progress
      ..subScriptionProgress = subScriptionProgress
      ..duration = duration
      ..dragging = dragging
      ..musics = musics;
  }
}

DetailPageState initState(Map<String, dynamic> args) {
  return DetailPageState()
    ..dragging = false
    ..detail = args['music']
    ..isPlaying = args['isPlaying']
    ..player = args['player']
    ..progress = args['progress']
    ..duration = args['duration']
    ..musics = args['musics'];
}
