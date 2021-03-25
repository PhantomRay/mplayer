import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeTheme: _onChangeTheme,
    },
  );
}

GlobalState _onChangeTheme(GlobalState state, Action action) {
  final GlobalState newState = state.clone();

  newState.themeData = action.payload;

  return newState;
}
