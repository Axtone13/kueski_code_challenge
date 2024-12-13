import 'package:kueski_code_challenge/features/movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies();
}
