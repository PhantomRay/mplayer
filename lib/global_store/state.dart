import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

abstract class GlobalBaseState {
  ThemeData get themeData;
  set themeData(ThemeData themeData);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  ThemeData themeData;

  @override
  GlobalState clone() {
    return GlobalState()..themeData = themeData;
  }
}
