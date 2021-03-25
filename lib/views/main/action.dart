import 'package:fish_redux/fish_redux.dart';

enum MainPageAction {
  action,
  select,
  pasue,
  resume,
  next,
  play,
  stop,
  progress,
}

class MainPageActionCreator {
  static Action onAction() {
    return const Action(MainPageAction.action);
  }

  static Action onSelect(dynamic args) {
    return Action(MainPageAction.select, payload: args);
  }

  static Action onPause() {
    return const Action(MainPageAction.pasue);
  }

  static Action onResume() {
    return const Action(MainPageAction.resume);
  }

  static Action onNext() {
    return const Action(MainPageAction.next);
  }

  static Action onPlay(dynamic args) {
    return Action(MainPageAction.play, payload: args);
  }

  static Action onStop() {
    return const Action(MainPageAction.stop);
  }

  static Action onProgress(dynamic args) {
    return Action(MainPageAction.progress, payload: args);
  }
}
