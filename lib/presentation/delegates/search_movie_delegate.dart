

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({
    required this.searchMovies
  });

  // NOTE - Placeholder del input
  @override
  String get searchFieldLabel => 'Buscar película';

  // NOTE - Button to clear input of search
  @override
  List<Widget>? buildActions(BuildContext context) {

    // print('query: $query');

    return [
        FadeIn(
          animate: query.isNotEmpty,
          // duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.clear)
          ),
        )
    ];
  }

  // NOTE - Button icon to back
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  // NOTE - Result of search
  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResult');
  }

  // NOTE - Show possible result
  @override
  Widget buildSuggestions(BuildContext context) {

      return FutureBuilder(
        future: searchMovies(query),
        builder: (context, snapshot) {

          final movies = snapshot.data ?? [];

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return ListTile(title: Text(movie.title));
            },
          );
        },
      );
  }

}