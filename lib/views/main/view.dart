import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:player/components/water_ripple.dart';
import 'package:player/models/music_model.dart';
import 'package:player/services/route_animation.dart';
import 'package:player/views/detail/page.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(MainPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _bottomController() {
    if (state.currentMusic == null) return SizedBox();

    MusicModel model = state.currentMusic;

    Widget image = ClipRRect(borderRadius: BorderRadius.circular(999), child: Image.network(model.albumArt));
    image = Container(width: 60, height: 60, child: image);

    Widget title = Text(model.title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal));
    title = GestureDetector(
      onTap: () {
        Navigator.of(viewService.context).push(
          PopUpRoute(DetailPage().buildPage({
            'music': state.currentMusic,
            'player': state.player,
            'isPlaying': state.isPlaying,
            'progress': state.progress,
            'duration': state.duration,
            'musics': state.musics,
          })),
        );
      },
      child: title,
    );

    Widget nextBtn = Icon(Icons.fast_forward);

    nextBtn = GestureDetector(
      onTap: () => dispatch(MainPageActionCreator.onNext()),
      child: nextBtn,
    );

    Widget pauseBtn = state.player.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow);
    pauseBtn = GestureDetector(
      onTap: () => state.player.isPlaying
          ? dispatch(MainPageActionCreator.onPause())
          : state.player.isPaused
              ? dispatch(MainPageActionCreator.onResume())
              : dispatch(MainPageActionCreator.onSelect(state.currentMusic)),
      child: pauseBtn,
    );

    Widget current = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        image,
        SizedBox(width: 10),
        Expanded(child: title),
        pauseBtn,
        SizedBox(width: 10),
        nextBtn,
      ],
    );

    current = Container(
      color: Color(0xffeeeeee).withOpacity(0.95),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: current,
    );

    current = Column(
      children: [
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 2.0,
          percent: state.duration == 0 ? 0.0 : state.progress / state.duration,
          progressColor: Colors.blue,
          backgroundColor: Color(0xffeeeeee).withOpacity(0.95),
        ),
        current,
      ],
    );

    return current;
  }

  Widget _searchInput() {
    Widget current = TextField(
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.blue,
      maxLength: 100,
      maxLines: 1,
      decoration: InputDecoration(
        isCollapsed: true,
        counterText: '',
        hintText: 'In Apple Music',
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 5, top: 6, right: 5, bottom: 6),
      ),
    );

    current = Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
      child: current,
    );

    current = Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: current),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.search, color: Colors.grey[500]),
          ),
          SizedBox(width: 10),
        ],
      ),
    );

    return current;
  }

  return Scaffold(
    appBar: AppBar(
      title: _searchInput(),
      centerTitle: true,
      titleSpacing: 0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    body: Stack(
      children: [
        Column(
          children: [
            Divider(height: 0.1),
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 100),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => dispatch(MainPageActionCreator.onSelect(state.musics[index])),
                        child: MusicSummary(music: state.musics[index], selected: state.musics[index].id == state.currentMusic?.id && state.isPlaying),
                      ),
                  separatorBuilder: (context, index) => Divider(height: 0.5, indent: 15, endIndent: 15),
                  itemCount: state.musics.length),
            ),
          ],
        ),
        Positioned(left: 0, bottom: 0, right: 0, child: _bottomController()),
      ],
    ),
  );
}

class MusicSummary extends StatelessWidget {
  final MusicModel music;
  final bool selected;
  const MusicSummary({Key key, @required this.music, @required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(music.albumArt),
    );

    image = Container(
      width: 60,
      height: 60,
      child: image,
    );

    Widget center = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(music.title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        SizedBox(height: 3),
        Text(music.artist, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45)),
        SizedBox(height: 3),
        Text(music.album, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.black45)),
      ],
    );

    Widget right = selected
        ? Container(
            height: 40,
            width: 40,
            child: Stack(
              children: [
                Container(child: WaterRipple(), width: 40, height: 40),
                Center(child: Icon(Icons.music_note, size: 12, color: Colors.white)),
              ],
            ),
          )
        : SizedBox();

    Widget current = Row(
      children: [
        image,
        SizedBox(width: 10),
        Expanded(child: center),
        SizedBox(width: 10),
        right,
      ],
    );

    current = Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: current,
    );
    return current;
  }
}
