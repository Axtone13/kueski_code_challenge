import 'package:movies_app_challenge/features/movies/domain/entities/genre.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';
import 'package:movies_app_challenge/features/movies/domain/repositories/movies_repository.dart';

class GetPopularMoviesUseCase {
  final MoviesRepository repository;

  GetPopularMoviesUseCase({required this.repository});

  Future<List<Movie>> call(String lang, int page) {
    return repository.getPopularMovies(lang, page);
  }
}

class GetGenresUseCase {
  final MoviesRepository repository;

  GetGenresUseCase({required this.repository});

  Future<List<Genre>> call(String lang) {
    return repository.getMovieGenres(lang);
  }
}
