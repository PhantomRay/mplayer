import 'package:fish_redux/fish_redux.dart';

enum MainPageAction {
  action,
  select,
  pasue,
  resume,
  next,
  play,
  stop,
  reveive,
  load,
  search,
  searching,
  showClear,
  clear,
  toggle,
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

  static Action onReveive(dynamic args) {
    return Action(MainPageAction.reveive, payload: args);
  }

  static Action onLoad(dynamic args) {
    return Action(MainPageAction.load, payload: args);
  }

  static Action onSearch() {
    return Action(MainPageAction.search);
  }

  static Action onSearching() {
    return Action(MainPageAction.searching);
  }

  static Action onShowClear() {
    return Action(MainPageAction.showClear);
  }

  static Action onClear() {
    return Action(MainPageAction.clear);
  }

  static Action onToggle(dynamic args) {
    return Action(MainPageAction.toggle, payload: args);
  }
}
