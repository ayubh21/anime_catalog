// ignore_for_file: avoid_print

class AnimeData {
  List<Anime> data;

  AnimeData({required this.data});
  factory AnimeData.fromJson(Map<String, dynamic> json) => AnimeData(
        data: List<Anime>.from(json["data"].map((x) => Anime.fromJson(x))),
      );
}

class Anime {
  String? title;
  String imageUrl;
  String? titleEnglish;
  String? titleJapanese;
  String? synopsis;
  String? rating;
  String? startDate;
  String? endDate;
  // double score;

  Anime(
      {this.title,
      required this.imageUrl,
      this.titleEnglish,
      this.titleJapanese,
      this.synopsis,
      this.rating,
      this.startDate,
      // required this.score,
      this.endDate});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        title: json["title"],
        imageUrl: json["images"]["webp"]["large_image_url"],
        titleEnglish: json["title_english"],
        titleJapanese: json["title_japanese"],
        synopsis: json["synopsis"],
        rating: json["rating"],
        startDate: json["aired"]["from"],
        endDate: json["aired"]["to"]);
  }
}
