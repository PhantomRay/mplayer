import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MainPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MainPageState>>{
      MainPageAction.play: _onPlay,
      MainPageAction.stop: _onStop,
      MainPageAction.pasue: _onPause,
      MainPageAction.resume: _onResume,
      MainPageAction.load: _onLoad,
      MainPageAction.searching: _onSearching,
      MainPageAction.showClear: _onShowClear,
      MainPageAction.clear: _onClear,
    },
  );
}

MainPageState _onPlay(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = action.payload['duration'].inMilliseconds == 0 ? false : true;
  newState.currentMusic = action.payload['music'];
  newState.duration = action.payload['duration'].inMilliseconds;

  return newState;
}

MainPageState _onStop(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = false;
  newState.duration = 0;
  newState.progress = 0;
  newState.currentMusic = null;

  return newState;
}

MainPageState _onPause(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = false;

  return newState;
}

MainPageState _onResume(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.isPlaying = true;

  return newState;
}

MainPageState _onLoad(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.musics = action.payload;
  newState.searching = false;

  return newState;
}

MainPageState _onSearching(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.searching = true;

  return newState;
}

MainPageState _onShowClear(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.showClearIcon = true;

  return newState;
}

MainPageState _onClear(MainPageState state, Action action) {
  final MainPageState newState = state.clone();

  newState.txtController.text = "";
  newState.showClearIcon = false;

  return newState;
}
