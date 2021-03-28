import 'dart:async';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import '../../models/music_model.dart';

class DetailPageState implements Cloneable<DetailPageState> {
  FlutterSoundPlayer player;
  MusicModel detail;
  bool isPlaying;
  int duration;
  int progress;
  StreamSubscription subScriptionProgress;

  List<MusicModel> musics;
  bool loading;
  bool isFirst;
  bool isLast;

  @override
  DetailPageState clone() {
    return DetailPageState()
      ..player = player
      ..detail = detail
      ..isPlaying = isPlaying
      ..progress = progress
      ..subScriptionProgress = subScriptionProgress
      ..duration = duration
      ..musics = musics
      ..loading = loading
      ..isFirst = isFirst
      ..isLast = isLast;
  }
}

DetailPageState initState(Map<String, dynamic> args) {
  return DetailPageState()
    ..detail = args['music']
    ..isPlaying = args['isPlaying']
    ..player = args['player']
    ..progress = args['progress']
    ..duration = args['duration']
    ..musics = args['musics']
    ..loading = false
    ..isFirst = false
    ..isLast = false;
}
