import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

updateGlobalStore() => (Object pageState, GlobalState appState) {
      final GlobalBaseState p = pageState;

      if (pageState is Cloneable) {
        final Object copy = pageState.clone();
        final GlobalBaseState newState = copy;

        if (p.themeData != appState.themeData) newState.themeData = appState.themeData;

        return newState;
      }

      return pageState;
    };
