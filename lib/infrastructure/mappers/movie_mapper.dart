import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/movie_for_movie_db.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieForMovieDb movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/${movieDb.backdropPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCJzZtX0QQx9i6I7Uilz5uQEz8VedSukgzGL_NiDMU_5PXyCf0K8LtsSnET3EWVu1JZ6w',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/${movieDb.posterPath}'
          // : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCJzZtX0QQx9i6I7Uilz5uQEz8VedSukgzGL_NiDMU_5PXyCf0K8LtsSnET3EWVu1JZ6w',
          : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);
}
