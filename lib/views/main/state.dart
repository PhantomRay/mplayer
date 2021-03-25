import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:player/models/music_model.dart';

class MainPageState implements Cloneable<MainPageState> {
  FlutterSoundPlayer player;
  MusicModel currentMusic;
  bool isPlaying;
  int duration;
  int progress;
  StreamSubscription subScriptionProgress;
  List<MusicModel> musics;

  @override
  MainPageState clone() {
    return MainPageState()
      ..player = player
      ..currentMusic = currentMusic
      ..isPlaying = isPlaying
      ..progress = progress
      ..subScriptionProgress = subScriptionProgress
      ..duration = duration
      ..musics = musics;
  }
}

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState()
    ..isPlaying = false
    ..player = FlutterSoundPlayer()
    ..progress = 0
    ..duration = 0
    ..musics = [
      MusicModel()
        ..id = '1'
        ..title = 'Take Me To Your Heart'
        ..artist = 'Michael Learns To Rock'
        ..album = 'That\'s WhyYou Go Away'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000003do5X80XB6qU_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/hot/2004/10-13/61171.mp3',
      MusicModel()
        ..id = '2'
        ..artist = 'Jasmine Thompson'
        ..title = 'Like I\'m Gonna Lose You'
        ..album = 'Like I\'m Gonna Lose You'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000001cUvKs0metut_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2015/12/30/668798.mp3',
      MusicModel()
        ..id = '3'
        ..artist = 'Maroon 5'
        ..title = 'Sugar'
        ..album = 'V (Deluxe Version)'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M0000006ftqt2nAMYV_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2016/04/09/wtm40v32sgc.mp3',
      MusicModel()
        ..id = '4'
        ..title = 'Take Me To Your Heart'
        ..artist = 'Michael Learns To Rock'
        ..album = 'That\'s WhyYou Go Away'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000003do5X80XB6qU_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/hot/2004/10-13/61171.mp3',
      MusicModel()
        ..id = '5'
        ..artist = 'Jasmine Thompson'
        ..title = 'Like I\'m Gonna Lose You'
        ..album = 'Like I\'m Gonna Lose You'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000001cUvKs0metut_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2015/12/30/668798.mp3',
      MusicModel()
        ..id = '6'
        ..artist = 'Maroon 5'
        ..title = 'Sugar'
        ..album = 'V (Deluxe Version)'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M0000006ftqt2nAMYV_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2016/04/09/wtm40v32sgc.mp3',
      MusicModel()
        ..id = '7'
        ..title = 'Take Me To Your Heart'
        ..artist = 'Michael Learns To Rock'
        ..album = 'That\'s WhyYou Go Away'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000003do5X80XB6qU_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/hot/2004/10-13/61171.mp3',
      MusicModel()
        ..id = '8'
        ..artist = 'Jasmine Thompson'
        ..title = 'Like I\'m Gonna Lose You'
        ..album = 'Like I\'m Gonna Lose You'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000001cUvKs0metut_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2015/12/30/668798.mp3',
      MusicModel()
        ..id = '9'
        ..artist = 'Maroon 5'
        ..title = 'Sugar'
        ..album = 'V (Deluxe Version)'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M0000006ftqt2nAMYV_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2016/04/09/wtm40v32sgc.mp3',
      MusicModel()
        ..id = '10'
        ..title = 'Take Me To Your Heart'
        ..artist = 'Michael Learns To Rock'
        ..album = 'That\'s WhyYou Go Away'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000003do5X80XB6qU_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/hot/2004/10-13/61171.mp3',
      MusicModel()
        ..id = '11'
        ..artist = 'Jasmine Thompson'
        ..title = 'Like I\'m Gonna Lose You'
        ..album = 'Like I\'m Gonna Lose You'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000001cUvKs0metut_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2015/12/30/668798.mp3',
      MusicModel()
        ..id = '12'
        ..artist = 'Maroon 5'
        ..title = 'Sugar'
        ..album = 'V (Deluxe Version)'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M0000006ftqt2nAMYV_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2016/04/09/wtm40v32sgc.mp3',
      MusicModel()
        ..id = '12'
        ..title = 'Take Me To Your Heart'
        ..artist = 'Michael Learns To Rock'
        ..album = 'That\'s WhyYou Go Away'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000003do5X80XB6qU_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/hot/2004/10-13/61171.mp3',
      MusicModel()
        ..id = '14'
        ..artist = 'Jasmine Thompson'
        ..title = 'Like I\'m Gonna Lose You'
        ..album = 'Like I\'m Gonna Lose You'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M000001cUvKs0metut_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2015/12/30/668798.mp3',
      MusicModel()
        ..id = '15'
        ..artist = 'Maroon 5'
        ..title = 'Sugar'
        ..album = 'V (Deluxe Version)'
        ..albumArt = 'https://y.gtimg.cn/music/photo_new/T002R300x300M0000006ftqt2nAMYV_1.jpg?max_age=2592000'
        ..url = 'https://mp3.jiuku.9ku.com/upload/128/2016/04/09/wtm40v32sgc.mp3',
    ];
}
