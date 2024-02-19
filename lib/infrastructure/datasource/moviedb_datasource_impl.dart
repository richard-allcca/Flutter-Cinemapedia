import 'package:cinemapedia/infrastructure/models/movieDb/movie_details.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_response.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDbDataSource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'lenguage': 'es-PE'
      }
    )
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> data){
    final movieDbResponse = MovieDbResponse.fromJson(data);

    final List<Movie> movies = movieDbResponse.results
        .where((element) => element.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    try {
      final response =
          await dio.get('/movie/now_playing', queryParameters: {'page': page});

      return _jsonToMovies(response.data);
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    try {
      final response =
          await dio.get('/movie/popular', queryParameters: {'page': page});

      return _jsonToMovies(response.data);
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    try {
      final response =
          await dio.get('/movie/top_rated', queryParameters: {'page': page});

      return _jsonToMovies(response.data);
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    try {
      final response =
          await dio.get('/movie/upcoming', queryParameters: {'page': page});

      return _jsonToMovies(response.data);
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

  @override
  Future<Movie> getMovieById(String id) async {
    try {
      final response = await dio.get('/movie/$id');
      if(response.statusCode != 200) throw Exception('Movie not found');

      final movieDetails = MovieDetails.fromJson(response.data);

      final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

      return movie;
    } catch (e) {
      // print('Error: $e');
      return throw Exception('fallo la búsqueda del video por Id');
    }
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {

    if ( query.isEmpty ) return [];

    try {
      final response =
          await dio.get('/search/movie',
            queryParameters: {
              'query': query
            }
          );

      return _jsonToMovies(response.data);
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }
}