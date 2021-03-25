import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    MainPageAction.select: _onSelect,
    MainPageAction.next: _onNext,
  });
}

void _onDispose(Action action, Context<MainPageState> ctx) {
  ctx.state.player.closeAudioSession();
  ctx.state.player = null;

  ctx.state.subScriptionProgress?.cancel();
  ctx.state.subScriptionProgress = null;
}

_onInit(Action action, Context<MainPageState> ctx) async {
  await ctx.state.player.openAudioSession();
  await ctx.state.player.setSubscriptionDuration(Duration(milliseconds: 1));
  ctx.state.subScriptionProgress = ctx.state.player.onProgress.listen((event) {
    if (ctx.state.isPlaying == false) return;
    ctx.dispatch(MainPageActionCreator.onProgress(event.position.inMilliseconds));
  });
}

_onSelect(Action action, Context<MainPageState> ctx) async {
  Duration duration = await ctx.state.player.startPlayer(fromURI: action.payload.url, whenFinished: () => ctx.dispatch(MainPageActionCreator.onStop()));

  ctx.dispatch(MainPageActionCreator.onPlay({'music': action.payload, 'duration': duration}));
}

_onNext(Action action, Context<MainPageState> ctx) async {
  int index = ctx.state.musics.indexOf(ctx.state.currentMusic);
  if (index + 1 > ctx.state.musics.length) return;

  ctx.dispatch(MainPageActionCreator.onSelect(ctx.state.musics[index + 1]));
}
