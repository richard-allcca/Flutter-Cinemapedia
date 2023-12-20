import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MoviesHomeScreen extends StatelessWidget {
  static String name = 'movie_home_screen';

  const MoviesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Cinema'),
      ),
      body: const _HomeView(),
      bottomNavigationBar: const CustomNavBarBottom(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Full list of videos
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // Exclusive provider to cut movie list
    final slidesShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(children: [
            // const CustomAppBar(),
            MoviesSlidesShow(movies: slidesShowMovies),
            MovieHorizontalList(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Lunes 20',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalList(
              movies: nowPlayingMovies,
              title: 'Próximamente',
              subTitle: 'En este mes',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalList(
              movies: nowPlayingMovies,
              title: 'Populares',
              subTitle: 'Del mes',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalList(
              movies: nowPlayingMovies,
              title: 'Mejor calificadas',
              subTitle: 'De siempre',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 20),
          ]);
        }, childCount: 1))
      ],
    );
  }
}
