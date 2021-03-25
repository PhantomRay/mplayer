import 'package:fish_redux/fish_redux.dart';

class DetailPageState implements Cloneable<DetailPageState> {

  @override
  DetailPageState clone() {
    return DetailPageState();
  }
}

DetailPageState initState(Map<String, dynamic> args) {
  return DetailPageState();
}
