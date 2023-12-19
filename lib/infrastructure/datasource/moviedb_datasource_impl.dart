import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_response.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDbDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'lenguage': 'es-PE'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    try {
      final response = await dio.get('/movie/now_playing');
      final movieDbResponse = MovieDbResponse.fromJson(response.data);
      final List<Movie> movies = movieDbResponse.results
          .where((element) => element.posterPath != 'no-poster')
          .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
          .toList();
      return movies;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
