import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DetailPageAction { action }

class DetailPageActionCreator {
  static Action onAction() {
    return const Action(DetailPageAction.action);
  }
}
