import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_catalog/models/anime.dart';
import 'package:movie_catalog/models/api/api.dart';
import 'package:movie_catalog/widgets/mytoprated_movies.dart';
import 'package:movie_catalog/widgets/trending_anime.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Anime>> myAnimeList;

  @override
  initState() {
    super.initState(); // function that runs as soon as the app is built
    myAnimeList = Aniapi().getMyAnimeList();
    // ignore: avoid_print
    print(myAnimeList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My Catalog'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Anime List',
                  style: GoogleFonts.aBeeZee(fontSize: 25),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    child: FutureBuilder(
                  future: myAnimeList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // ignore: avoid_print
                      print(myAnimeList);
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    if (snapshot.hasData) {
                      print(TrendingAnime(
                        snapshot: snapshot,
                        setStateCallback: () {},
                      ));
                      return TrendingAnime(
                        snapshot: snapshot,
                        setStateCallback: () {},
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
                const SizedBox(height: 32),
                Text(
                  'My All time Favorite Anime',
                  style: GoogleFonts.aBeeZee(fontSize: 25),
                ),
                const SizedBox(height: 32),
                const MyTopRatedMovies()
              ],
            ),
          )),
    );
  }
}
