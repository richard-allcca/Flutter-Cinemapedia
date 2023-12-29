


// Este repositorio es inmutable
import 'package:cinemapedia/infrastructure/datasource/actor_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repository/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(ActorMovieDbDataSource());
});