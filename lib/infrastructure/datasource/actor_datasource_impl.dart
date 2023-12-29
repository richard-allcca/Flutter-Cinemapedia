import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/credits_response.dart';
import 'package:dio/dio.dart';


class ActorMovieDbDataSource extends ActorsDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'lenguage': 'es-PE'
      }
    )
  );

  List<Actor> _jsonToCast(Map<String, dynamic> data){
    final castResponse = CreditsResponse.fromJson(data);

    final List<Actor> actors = castResponse.cast
      .map((element) => ActorMapper.castToEntity(element))
      .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    try {
      final response =
          await dio.get('/movie/$movieId/credits');

      return _jsonToCast(response.data);
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

}