import 'package:fish_redux/fish_redux.dart';

enum DetailPageAction {
  select,
  pasue,
  resume,
  next,
  play,
  stop,
  progress,
  changeProgress,
  seekProgress,
  drag,
  previous,
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

  static Action onProgress(dynamic args) {
    return Action(DetailPageAction.progress, payload: args);
  }

  static Action onChangeProgress(dynamic args) {
    return Action(DetailPageAction.changeProgress, payload: args);
  }

  static Action onSeekProgress(dynamic args) {
    return Action(DetailPageAction.seekProgress, payload: args);
  }

  static Action onDrag(dynamic args) {
    return Action(DetailPageAction.drag, payload: args);
  }
}
