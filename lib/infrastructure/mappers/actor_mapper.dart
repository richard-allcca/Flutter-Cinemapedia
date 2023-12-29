

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity( Cast cast ) =>
    Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://www.svgrepo.com/show/452030/avatar-default.svg',
      character: cast.character
    );
}