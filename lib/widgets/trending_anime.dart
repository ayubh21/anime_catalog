// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_catalog/models/anime.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrendingAnime extends StatefulWidget {
  const TrendingAnime({
    Key? key,
    required this.setStateCallback,
    required AsyncSnapshot<List<Anime>> snapshot,
  }) : super(key: key);

  final VoidCallback setStateCallback;

  @override
  // ignore: library_private_types_in_public_api
  _TrendingAnimeState createState() => _TrendingAnimeState();
}

class _TrendingAnimeState extends State<TrendingAnime> {
  List<Anime> animeList = [];

  @override
  void initState() {
    super.initState();
    fetchAnimePosters();
  }

  Future<void> fetchAnimePosters() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/anime'));

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body)["data"] as List;
      final List<dynamic> animeDataList = decodedJson;

      print(decodedJson);

      setState(() {
        animeList = animeDataList.map((animeData) {
          return Anime(
              title: animeData["title"],
              imageUrl: animeData["images"]["webp"]["large_image_url"]);
        }).toList();
      });

      print(animeList.length);
      // Call the parent's setState method after updating the state
      widget.setStateCallback();
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: animeList.length,
        options: CarouselOptions(
          height: 299,
          autoPlay: true,
          viewportFraction: 0.55,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          enlargeCenterPage: true,
          pageSnapping: true,
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          final anime = animeList[itemIndex];
          print(anime.imageUrl);
          return ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: SizedBox(
              height: 299,
              width: 199,
              child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  anime.imageUrl),
            ),
          );
        },
      ),
    );
  }
}
