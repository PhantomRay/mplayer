import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DetailPageState>>{
      DetailPageAction.progress: _onProgress,
      DetailPageAction.pasue: _onPause,
      DetailPageAction.resume: _onResume,
      DetailPageAction.play: _onPlay,
      DetailPageAction.stop: _onStop,
      DetailPageAction.changeProgress: _onChangeProgress,
      DetailPageAction.drag: _onDrag,
    },
  );
}

DetailPageState _onPlay(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isPlaying = true;
  newState.detail = action.payload['music'];
  newState.duration = action.payload['duration'].inMilliseconds;

  return newState;
}

DetailPageState _onStop(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isPlaying = false;
  newState.duration = 0;
  newState.progress = 0;

  return newState;
}

DetailPageState _onProgress(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.progress = action.payload;

  return newState;
}

DetailPageState _onPause(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isPlaying = false;
  newState.player.pausePlayer();

  return newState;
}

DetailPageState _onResume(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isPlaying = true;
  newState.player.resumePlayer();

  return newState;
}

DetailPageState _onChangeProgress(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.progress = (action.payload * state.duration).toInt();

  return newState;
}

DetailPageState _onDrag(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.dragging = action.payload;

  return newState;
}
