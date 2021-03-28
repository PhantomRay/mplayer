class MusicModel {
  int id;
  String title;
  String artist;
  String artwork;
  String url;

  static MusicModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    MusicModel model = MusicModel();

    model.id = json['trackId'];
    model.title = json['trackName'];
    model.artist = json['artistName'];
    model.artwork = json['artworkUrl100'];
    model.url = json['previewUrl'];

    return model;
  }

  static List<MusicModel> fromMapList(dynamic mapList) {
    List<MusicModel> models = [];

    for (dynamic map in mapList) models.add(fromJson(map));

    return models;
  }
}
