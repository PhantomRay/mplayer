import 'dart:async';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import '../../models/music_model.dart';

class MainPageState implements Cloneable<MainPageState> {
  FlutterSoundPlayer player;
  MusicModel currentMusic;
  bool isPlaying;
  int duration;
  int progress;
  StreamSubscription subScriptionProgress;
  List<MusicModel> musics;
  TextEditingController txtController;
  bool searching;
  bool showClearIcon;

  @override
  MainPageState clone() {
    return MainPageState()
      ..player = player
      ..currentMusic = currentMusic
      ..isPlaying = isPlaying
      ..progress = progress
      ..subScriptionProgress = subScriptionProgress
      ..duration = duration
      ..musics = musics
      ..txtController = txtController
      ..searching = searching
      ..showClearIcon = showClearIcon;
  }
}

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState()
    ..isPlaying = false
    ..player = FlutterSoundPlayer()
    ..progress = 0
    ..duration = 0
    ..searching = true
    ..showClearIcon = true
    ..txtController = TextEditingController();
}
