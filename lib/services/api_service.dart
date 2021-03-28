import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/music_model.dart';
import 'http.dart';

class ApiService {
  static Future<List<MusicModel>> search({String keyword, int pageSize}) async {
    pageSize = pageSize ?? 25;

    keyword = keyword.replaceAll(new RegExp(r'[ ]+'), '+');

    String url = "https://itunes.apple.com/search?term={keyword}&limit=25&media=music";

    url = url.replaceAll('{keyword}', keyword);

    Response response = await Http.instance.getBytes(url);

    String data = utf8.decode(response.data);

    var models = MusicModel.fromMapList(jsonDecode(data)['results']);

    return models;
  }
}
