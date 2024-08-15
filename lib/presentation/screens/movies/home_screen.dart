import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'movie_home_screen';

  const HomeScreen({super.key});

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

// NOTE -  ConsumerStatefulWidget: Permite leer los providers
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

// NOTE - ConsumerState: permite el acceso a los estados mediante el ref
class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(populateMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    // Full list of videos
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // Full list of videos populates
    final populatePlayingMovies = ref.watch(populateMoviesProvider);

    // Full list of videos top rated
    final topRatedPlayingMovies = ref.watch(topRatedMoviesProvider);

    // Full list of videos upcoming
    final upcomingPlayingMovies = ref.watch(upcomingMoviesProvider);

    // Exclusive provider to cut movie list
    final slidesShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 0, bottom: 5),
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
              movies: upcomingPlayingMovies,
              title: 'Próximamente',
              subTitle: 'En este mes',
              loadNextPage: () =>
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalList(
              movies: populatePlayingMovies,
              title: 'Populares',
              subTitle: 'Del mes',
              loadNextPage: () =>
                  ref.read(populateMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalList(
              movies: topRatedPlayingMovies,
              title: 'Mejor calificadas',
              subTitle: 'De siempre',
              loadNextPage: () =>
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 20),
          ]);
        }, childCount: 1))
      ],
    );
  }
}
