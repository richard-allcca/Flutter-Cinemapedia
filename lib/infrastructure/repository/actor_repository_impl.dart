import 'package:cinemapedia/domain/datasources/actors_datasource.dart';

import 'package:cinemapedia/domain/entities/actor.dart';


class ActorsRepositoryImpl extends ActorsDataSource {

  final ActorsDataSource dataSource;

  ActorsRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }

}