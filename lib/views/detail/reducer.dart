import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DetailPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DetailPageState>>{
      DetailPageAction.pasue: _onPause,
      DetailPageAction.resume: _onResume,
      DetailPageAction.play: _onPlay,
      DetailPageAction.stop: _onStop,
      DetailPageAction.loading: _onLoading,
      DetailPageAction.first: _onFirst,
      DetailPageAction.last: _onLast,
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

DetailPageState _onPause(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isPlaying = false;

  return newState;
}

DetailPageState _onResume(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isPlaying = true;

  return newState;
}

DetailPageState _onLoading(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.loading = action.payload;
  if (action.payload) newState.progress = 0;

  return newState;
}

DetailPageState _onFirst(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isFirst = action.payload;

  return newState;
}

DetailPageState _onLast(DetailPageState state, Action action) {
  final DetailPageState newState = state.clone();

  newState.isLast = action.payload;

  return newState;
}
