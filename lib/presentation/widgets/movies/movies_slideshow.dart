import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class MoviesSlidesShow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlidesShow({
    super.key,
    required this.movies
  });

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: color.secondary,
            color: color.inversePrimary
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {

          return _Slide(movie: movies[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({ required this.movie });

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10, // difuminado
          offset: Offset(0,10) // dirección del boxShadow
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Color.fromARGB(31, 238, 12, 12)),
                );
              }
              return FadeIn(child: child);
            },
          )
        ),
      ),
    );
  }
}