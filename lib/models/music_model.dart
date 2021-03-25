class MusicModel {
  String id;
  String title;
  String artist;
  String album;
  String albumArt;
  String url;

  static MusicModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    MusicModel model = MusicModel();

    model.id = json['id'];
    model.title = json['title'];
    model.artist = json['artist'];
    model.album = json['album'];
    model.albumArt = json['album_art'];
    model.url = json['url'];

    return model;
  }
}
