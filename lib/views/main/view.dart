import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/water_ripple.dart';
import '../../models/music_model.dart';
import '../../services/route_animation.dart';
import '../../views/detail/page.dart';
import '../../views/main/progress.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(MainPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _bottomController() {
    if (state.currentMusic == null) return SizedBox();

    MusicModel model = state.currentMusic;

    Widget image = ClipRRect(borderRadius: BorderRadius.circular(999), child: Image.network(model.artwork, fit: BoxFit.cover));
    image = Container(width: 60, height: 60, child: image);
    image = GestureDetector(
        onTap: () {
          Navigator.of(viewService.context).push(
            PopUpRoute(DetailPage().buildPage({
              'music': state.currentMusic,
              'player': state.player,
              'isPlaying': state.player.isPlaying,
              'progress': state.progress,
              'duration': state.duration,
              'musics': state.musics,
            })),
          );
        },
        child: image);

    Widget title = Text(model.title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal));
    title = Container(height: 60, child: title, color: Colors.transparent, alignment: Alignment.centerLeft);

    title = GestureDetector(
      onTap: () {
        Navigator.of(viewService.context).push(
          PopUpRoute(DetailPage().buildPage({
            'music': state.currentMusic,
            'player': state.player,
            'isPlaying': state.player.isPlaying,
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
      onTap: state.player.isPlaying
          ? () async {
              await state.player.pausePlayer();
              dispatch(MainPageActionCreator.onPause());
            }
          : state.player.isPaused
              ? () async {
                  await state.player.resumePlayer();
                  dispatch(MainPageActionCreator.onResume());
                }
              : () => dispatch(MainPageActionCreator.onSelect(state.currentMusic)),
      child: pauseBtn,
    );

    Widget current = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        image,
        SizedBox(width: 10),
        Expanded(child: title),
        pauseBtn,
        SizedBox(width: 15),
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
        Progress(player: state.player, duration: state.duration),
        current,
      ],
    );

    return current;
  }

  Widget _searchInput() {
    Widget current = TextField(
      style: TextStyle(color: Colors.black),
      controller: state.txtController,
      cursorColor: Colors.blue,
      maxLength: 100,
      maxLines: 1,
      decoration: InputDecoration(
        isCollapsed: true,
        counterText: '',
        hintText: 'In Apple Music',
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 10),
      ),
    );

    current = Row(
      children: [
        Expanded(child: current),
        state.showClearIcon
            ? GestureDetector(
                onTap: () => dispatch(MainPageActionCreator.onClear()),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(Icons.clear, color: Colors.white, size: 12),
                ),
              )
            : SizedBox(),
      ],
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
            onTap: () => dispatch(MainPageActionCreator.onSearch()),
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
        state.searching
            ? Center(child: CupertinoActivityIndicator(radius: 15))
            : state.musics.length == 0
                ? Center(child: Text('Not Found', style: TextStyle(color: Colors.grey, fontSize: 16)))
                : Column(
                    children: [
                      Divider(height: 0.1),
                      Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 100),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => dispatch(MainPageActionCreator.onSelect(state.musics[index])),
                                  child: MusicSummary(
                                    music: state.musics[index],
                                    selected: state.musics[index].id == state.currentMusic?.id,
                                    isPlaying: state.isPlaying || state.player.isPaused,
                                  ),
                                ),
                            separatorBuilder: (context, index) => Divider(height: 0.5, indent: 15, endIndent: 15),
                            itemCount: state.musics.length),
                      ),
                    ],
                  ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 1.0),
                  end: Offset(0.0, 0.0),
                ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            },
            child: _bottomController(),
          ),
        ),
      ],
    ),
  );
}

class MusicSummary extends StatelessWidget {
  final MusicModel music;
  final bool selected;
  final bool isPlaying;
  const MusicSummary({Key key, @required this.music, @required this.selected, @required this.isPlaying}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(music.artwork, fit: BoxFit.cover),
    );

    image = Container(
      width: 60,
      height: 60,
      child: image,
    );

    Widget center = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(music.title ?? '', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        SizedBox(height: 3),
        Text(music.artist ?? '', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45)),
      ],
    );

    Widget right = selected
        ? Container(
            height: 40,
            width: 40,
            child: isPlaying
                ? Stack(
                    children: [
                      Container(child: WaterRipple(), width: 40, height: 40),
                      Center(child: Icon(Icons.music_note, size: 12, color: Colors.white)),
                    ],
                  )
                : CupertinoActivityIndicator(),
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
