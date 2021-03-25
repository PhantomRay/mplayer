import 'package:fish_redux/fish_redux.dart';

enum GlobalAction {
  changeTheme,
}

class GlobalActionCreator {
  static Action onChangeTheme(dynamic payload) {
    return Action(GlobalAction.changeTheme, payload: payload);
  }
}
