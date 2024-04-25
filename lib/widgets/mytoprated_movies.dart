import 'package:flutter/material.dart';
// import 'dart:ui';

class MyTopRatedMovies extends StatelessWidget {
  const MyTopRatedMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                    height: 299,
                    width: 199,
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        'https://cdn.myanimelist.net/images/anime/1305/132237l.webp')),
              ));
        },
      ),
    );
  }
}
