import 'package:fish_redux/fish_redux.dart';

enum DetailPageAction {
  select,
  pasue,
  resume,
  next,
  play,
  stop,
  seekProgress,
  previous,
  loading,
  first,
  last,
  playCompleted,
}

class DetailPageActionCreator {
  static Action onSelect() {
    return Action(DetailPageAction.select);
  }

  static Action onPause() {
    return const Action(DetailPageAction.pasue);
  }

  static Action onResume() {
    return const Action(DetailPageAction.resume);
  }

  static Action onNext() {
    return const Action(DetailPageAction.next);
  }

  static Action onPrevious() {
    return const Action(DetailPageAction.previous);
  }

  static Action onPlay(dynamic args) {
    return Action(DetailPageAction.play, payload: args);
  }

  static Action onStop() {
    return const Action(DetailPageAction.stop);
  }

  static Action onSeekProgress(dynamic args) {
    return Action(DetailPageAction.seekProgress, payload: args);
  }

  static Action onLoading(dynamic args) {
    return Action(DetailPageAction.loading, payload: args);
  }

  static Action onFirst(dynamic args) {
    return Action(DetailPageAction.first, payload: args);
  }

  static Action onLast(dynamic args) {
    return Action(DetailPageAction.last, payload: args);
  }

  static Action onPlayCompleted() {
    return const Action(DetailPageAction.playCompleted);
  }
}
