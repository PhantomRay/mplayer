import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MainPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MainPageState>>{
      MainPageAction.play: _onPlay,
      MainPageAction.stop: _onStop,
      MainPageAction.progress: _onProgress,
      MainPageAction.pasue: _onPause,
      MainPageAction.resume: _onResume,
    },
  );
}

MainPageState _onPlay(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = true;
  newState.currentMusic = action.payload['music'];
  newState.duration = action.payload['duration'].inMilliseconds;

  return newState;
}

MainPageState _onStop(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = false;
  newState.duration = 0;
  newState.progress = 0;

  return newState;
}

MainPageState _onProgress(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.progress = action.payload;

  return newState;
}

MainPageState _onPause(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = false;
  newState.player.pausePlayer();

  return newState;
}

MainPageState _onResume(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = true;
  newState.player.resumePlayer();

  return newState;
}
