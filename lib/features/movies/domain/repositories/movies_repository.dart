import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies(String lang, int page);
}
