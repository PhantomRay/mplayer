import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import '../../services/api_service.dart';
import '../../views/detail/action.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    MainPageAction.select: _onSelect,
    MainPageAction.next: _onNext,
    MainPageAction.reveive: _onReveive,
    MainPageAction.search: _onSearch,
    MainPageAction.toggle: _onToggle,
  });
}

void _onDispose(Action action, Context<MainPageState> ctx) {
  ctx.state.player.closeAudioSession();
  ctx.state.player = null;

  ctx.state.subScriptionProgress?.cancel();
  ctx.state.subScriptionProgress = null;

  ctx.state.txtController.dispose();
}

_onInit(Action action, Context<MainPageState> ctx) async {
  ctx.state.txtController.text = 'jack johnson';

  ApiService.search(keyword: ctx.state.txtController.text).then((value) => ctx.dispatch(MainPageActionCreator.onLoad(value)));

  await ctx.state.player.openAudioSession();
  await ctx.state.player.setSubscriptionDuration(Duration(milliseconds: 1));
  ctx.state.subScriptionProgress = ctx.state.player.onProgress.listen((event) {
    if (ctx.state.player.isPlaying == false) return;
    ctx.state.progress = event.position.inMilliseconds;
  });

  ctx.state.txtController.addListener(() {
    String value = ctx.state.txtController.text;

    if (value.length > 0 && ctx.state.showClearIcon == false) ctx.dispatch(MainPageActionCreator.onShowClear());
  });
}

_onSelect(Action action, Context<MainPageState> ctx) async {
  ctx.dispatch(MainPageActionCreator.onPlay({'music': action.payload, 'duration': Duration(milliseconds: 0)}));

  ctx.state.player
      .startPlayer(
          fromURI: action.payload.url,
          whenFinished: () {
            ctx.dispatch(MainPageActionCreator.onStop());
            ctx.broadcast(DetailPageActionCreator.onPlayCompleted());
          })
      .then((duration) {
    ctx.dispatch(MainPageActionCreator.onPlay({'music': action.payload, 'duration': duration}));
  });
}

_onNext(Action action, Context<MainPageState> ctx) async {
  int position = ctx.state.progress + 5000;

  ctx.state.player.seekToPlayer(Duration(milliseconds: position));
}

_onReveive(Action action, Context<MainPageState> ctx) async {
  ctx.dispatch(MainPageActionCreator.onPlay(action.payload));
}

_onToggle(Action action, Context<MainPageState> ctx) async {
  if (action.payload == 'pause')
    ctx.dispatch(MainPageActionCreator.onPause());
  else
    ctx.dispatch(MainPageActionCreator.onResume());
}

_onSearch(Action action, Context<MainPageState> ctx) async {
  String keyword = ctx.state.txtController.text.trim();
  if (keyword == null || keyword.length == 0) {
    ScaffoldMessenger.of(ctx.context).showSnackBar(SnackBar(content: Text('Please Enter Keywords')));
    return;
  }

  FocusScope.of(ctx.context).requestFocus(FocusNode());

  ctx.dispatch(MainPageActionCreator.onSearching());

  ctx.state.player.stopPlayer();
  ctx.state.currentMusic = null;

  var models = await ApiService.search(keyword: keyword);
  ctx.dispatch(MainPageActionCreator.onLoad(models));
}
