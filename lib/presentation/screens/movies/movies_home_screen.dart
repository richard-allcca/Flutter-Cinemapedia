import 'package:cinemapedia/config/constants/environment.dart';
import 'package:flutter/material.dart';

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
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text( Environment.movieDbKey ),
      ),
    );
  }
}