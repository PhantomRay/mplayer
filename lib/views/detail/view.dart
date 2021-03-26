import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:player/services/utils.dart';
import 'package:player/views/detail/action.dart';
import 'state.dart';

Widget buildView(DetailPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _renderDuration() {
    Widget total = Text(
      Utils.formatTimeStyle(state.duration ~/ 1000),
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );

    Widget position = Text(
      Utils.formatTimeStyle(state.progress ~/ 1000),
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );

    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[position, total],
      ),
    );
  }

  return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        children: [
          GestureDetector(onTap: () => Navigator.of(viewService.context).pop(), child: Container(height: 100, color: Colors.transparent)),
          Expanded(
            child: Container(
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
                  Text(state.detail.album, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 30),
                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(state.detail.albumArt)),
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
                    padding: EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 10),
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 2,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayShape: SliderComponentShape.noOverlay,
                      ),
                      child: Slider(
                        onChangeStart: (value) => dispatch(DetailPageActionCreator.onDrag(true)),
                        onChanged: (v) => dispatch(DetailPageActionCreator.onChangeProgress(v)),
                        onChangeEnd: (v) => dispatch(DetailPageActionCreator.onSeekProgress(v)),
                        value: state.duration > 0 ? state.progress / state.duration : 0.0,
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
                          child: Icon(Icons.skip_previous, size: 32),
                        ),
                        GestureDetector(
                          onTap: () => state.player.isPlaying
                              ? dispatch(DetailPageActionCreator.onPause())
                              : state.player.isPaused
                                  ? dispatch(DetailPageActionCreator.onResume())
                                  : dispatch(DetailPageActionCreator.onSelect()),
                          child: Icon(state.player.isPlaying ? Icons.pause : Icons.play_arrow, size: 32),
                        ),
                        GestureDetector(
                          onTap: () => dispatch(DetailPageActionCreator.onNext()),
                          child: Icon(Icons.skip_next, size: 32),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ));
}
