import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../../views/main/action.dart';
import '../../components/rotation_disc.dart';
import '../../services/utils.dart';
import '../../views/detail/action.dart';
import 'progress.dart';
import 'state.dart';

Widget buildView(DetailPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _renderDuration() {
    Widget total = Text(
      Utils.formatTimeStyle(state.duration ~/ 1000),
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );

    Widget loading = state.loading ? Text('Loading', style: TextStyle(color: Colors.grey, fontSize: 12)) : Container();

    Widget position = Text(
      Utils.formatTimeStyle(state.progress ~/ 1000),
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );

    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[state.loading ? SizedBox() : position, loading, state.loading ? SizedBox() : total],
      ),
    );
  }

  return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(child: GestureDetector(onTap: () => Navigator.of(viewService.context).pop(), child: Container(height: 200, color: Colors.transparent))),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(viewService.context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(viewService.context).pop(),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 60, height: 3, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      RotationDisc(play: state.isPlaying, child: Container(height: 200, width: 200, child: Image.asset('assets/disc.png'))),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(60),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.network(state.detail.artwork, width: 50, height: 50, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(state.detail.title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    state.detail.artist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    state.detail.album,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 10),
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: SliderComponentShape.noOverlay,
                    ),
                    child: Progress(
                      player: state.player,
                      onChangeEnd: (v) => dispatch(DetailPageActionCreator.onSeekProgress(v)),
                      duration: state.duration,
                      loading: state.loading,
                    ),
                  ),
                ),
                _renderDuration(),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => dispatch(DetailPageActionCreator.onPrevious()),
                        child: Icon(Icons.skip_previous, size: 32, color: state.isFirst ? Colors.grey : Colors.black),
                      ),
                      GestureDetector(
                        onTap: state.player.isPlaying
                            ? () async {
                                await state.player.pausePlayer();
                                dispatch(DetailPageActionCreator.onPause());
                                viewService.broadcast(MainPageActionCreator.onToggle('pause'));
                              }
                            : state.player.isPaused
                                ? () async {
                                    await state.player.resumePlayer();
                                    dispatch(DetailPageActionCreator.onResume());
                                    viewService.broadcast(MainPageActionCreator.onToggle('resume'));
                                  }
                                : () => dispatch(DetailPageActionCreator.onSelect()),
                        child: Icon(state.player.isPlaying ? Icons.pause : Icons.play_arrow, size: 32),
                      ),
                      GestureDetector(
                        onTap: () => dispatch(DetailPageActionCreator.onNext()),
                        child: Icon(Icons.skip_next, size: 32, color: state.isLast ? Colors.grey : Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ));
}
