import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<DetailPageState>>{
    DetailPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DetailPageState> ctx) {
}
