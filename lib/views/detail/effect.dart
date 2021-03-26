import 'package:fish_redux/fish_redux.dart';
import 'package:player/views/main/action.dart';
import 'action.dart';
import 'state.dart';

Effect<DetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<DetailPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    DetailPageAction.select: _onSelect,
    DetailPageAction.seekProgress: _onSeekProgress,
    DetailPageAction.next: _onNext,
    DetailPageAction.previous: _onPrevious,
  });
}

void _onDispose(Action action, Context<DetailPageState> ctx) {
  ctx.state.subScriptionProgress?.cancel();
  ctx.state.subScriptionProgress = null;
}

_onInit(Action action, Context<DetailPageState> ctx) async {
  await ctx.state.player.setSubscriptionDuration(Duration(milliseconds: 1));
  ctx.state.subScriptionProgress = ctx.state.player.onProgress.listen((event) {
    if (ctx.state.player.isPlaying == false || ctx.state.dragging) return;
    ctx.dispatch(DetailPageActionCreator.onProgress(event.position.inMilliseconds));
  });
}

_onSeekProgress(Action action, Context<DetailPageState> ctx) async {
  ctx.state.player.seekToPlayer(Duration(milliseconds: (action.payload * ctx.state.duration).toInt()));
  ctx.dispatch(DetailPageActionCreator.onDrag(false));
}

_onSelect(Action action, Context<DetailPageState> ctx) async {
  Duration duration = await ctx.state.player.startPlayer(fromURI: ctx.state.detail.url, whenFinished: () => ctx.dispatch(DetailPageActionCreator.onStop()));

  ctx.dispatch(DetailPageActionCreator.onPlay({'music': ctx.state.detail, 'duration': duration}));
}

_onNext(Action action, Context<DetailPageState> ctx) async {
  int index = ctx.state.musics.indexOf(ctx.state.detail);
  if (index + 1 > ctx.state.musics.length) return;

  var model = ctx.state.musics[index + 1];

  Duration duration = await ctx.state.player.startPlayer(fromURI: model.url, whenFinished: () => ctx.dispatch(DetailPageActionCreator.onStop()));

  ctx.dispatch(DetailPageActionCreator.onPlay({'music': model, 'duration': duration}));

  ctx.broadcast(MainPageActionCreator.onReveive({'music': model, 'duration': duration}));
}

_onPrevious(Action action, Context<DetailPageState> ctx) async {
  int index = ctx.state.musics.indexOf(ctx.state.detail);
  if (index - 1 < 0) return;

  var model = ctx.state.musics[index - 1];

  Duration duration = await ctx.state.player.startPlayer(fromURI: model.url, whenFinished: () => ctx.dispatch(DetailPageActionCreator.onStop()));

  ctx.dispatch(DetailPageActionCreator.onPlay({'music': model, 'duration': duration}));

  ctx.broadcast(MainPageActionCreator.onReveive({'music': model, 'duration': duration}));
}
