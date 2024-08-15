import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          // padding: const EdgeInsets.only(right: 10, left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity, // todo el ancho que pueda
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color: colors.primary),

                const SizedBox(width: 5), // similar a un div con flex 1

                Text('Cinemapedia', style: titleStyle),

                const Spacer(), // separator

                IconButton(
                    onPressed: () {
                      // final searchMovies = ref.read(searchedMoviesProvider);
                      final searchQuery = ref.read(searchQueryProvider);

                      showSearch<Movie?>(
                          query: searchQuery,
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovies: ref
                                  .read(searchedMoviesProvider.notifier)
                                  .searchMoviesByQuery,
                              initialMovies: [])).then((movie) {
                        if (movie == null) return;

                        context.push('/movie/${movie.id}');
                      });
                    },
                    icon: const Icon(Icons.search)
                  )
              ],
            ),
          ),
        ));
  }
}
