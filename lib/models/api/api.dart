// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:movie_catalog/models/anime.dart';
import 'package:http/http.dart' as http;

class Aniapi {
  static const _myAnimeListUrl = 'https://api.jikan.moe/v4/anime';

  Future<List<Anime>> getMyAnimeList() async {
    final res = await http.get(Uri.parse(_myAnimeListUrl));
    if (res.statusCode != 200) {
      throw Exception("Error in fetching data");
    } else {
      final decodedJson = json.decode(res.body)["data"] as List;

      // print(decodedJson);
      return decodedJson.map((anime) => Anime.fromJson(anime)).toList();
    }
  }
}
