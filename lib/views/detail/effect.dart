import 'package:fish_redux/fish_redux.dart';
import '../../views/main/action.dart';
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
    DetailPageAction.playCompleted: _onPlayCompleted,
  });
}

void _onDispose(Action action, Context<DetailPageState> ctx) {
  ctx.state.subScriptionProgress?.cancel();
  ctx.state.subScriptionProgress = null;
}

_onInit(Action action, Context<DetailPageState> ctx) async {
  await ctx.state.player.setSubscriptionDuration(Duration(milliseconds: 1));

  _checkFirstLast(action, ctx);
}

_onSeekProgress(Action action, Context<DetailPageState> ctx) async {
  ctx.state.player.seekToPlayer(Duration(milliseconds: action.payload.toInt()));
}

_onSelect(Action action, Context<DetailPageState> ctx) async {
  Duration duration = await ctx.state.player.startPlayer(fromURI: ctx.state.detail.url, whenFinished: () => ctx.dispatch(DetailPageActionCreator.onStop()));

  ctx.dispatch(DetailPageActionCreator.onPlay({'music': ctx.state.detail, 'duration': duration}));
}

_onNext(Action action, Context<DetailPageState> ctx) async {
  int index = ctx.state.musics.indexOf(ctx.state.detail);
  if (index + 1 >= ctx.state.musics.length) return;

  ctx.dispatch(DetailPageActionCreator.onLoading(true));

  ctx.dispatch(DetailPageActionCreator.onPause());

  var model = ctx.state.musics[index + 1];

  ctx.state.player.startPlayer(fromURI: model.url, whenFinished: () => ctx.dispatch(DetailPageActionCreator.onStop())).then((duration) {
    ctx.dispatch(DetailPageActionCreator.onPlay({'music': model, 'duration': duration}));

    ctx.broadcast(MainPageActionCreator.onReveive({'music': model, 'duration': duration}));

    ctx.dispatch(DetailPageActionCreator.onLoading(false));
    _checkFirstLast(action, ctx);
  });
}

_onPrevious(Action action, Context<DetailPageState> ctx) async {
  int index = ctx.state.musics.indexOf(ctx.state.detail);
  if (index - 1 < 0) return;

  var model = ctx.state.musics[index - 1];

  ctx.dispatch(DetailPageActionCreator.onLoading(true));

  ctx.dispatch(DetailPageActionCreator.onPause());

  ctx.state.player.startPlayer(fromURI: model.url, whenFinished: () => ctx.dispatch(DetailPageActionCreator.onStop())).then((duration) {
    ctx.dispatch(DetailPageActionCreator.onPlay({'music': model, 'duration': duration}));

    ctx.broadcast(MainPageActionCreator.onReveive({'music': model, 'duration': duration}));

    ctx.dispatch(DetailPageActionCreator.onLoading(false));

    _checkFirstLast(action, ctx);
  });
}

_checkFirstLast(Action action, Context<DetailPageState> ctx) {
  int index = ctx.state.musics.indexOf(ctx.state.detail);

  if (index == 0) ctx.dispatch(DetailPageActionCreator.onFirst(true));
  if (index == ctx.state.musics.length - 1) ctx.dispatch(DetailPageActionCreator.onLast(true));

  if (index != 0 && index != ctx.state.musics.length - 1) {
    if (ctx.state.isFirst == true) ctx.dispatch(DetailPageActionCreator.onFirst(false));

    if (ctx.state.isLast == true) ctx.dispatch(DetailPageActionCreator.onLast(false));
  }
}

_onPlayCompleted(Action action, Context<DetailPageState> ctx) {
  ctx.dispatch(DetailPageActionCreator.onStop());
}
