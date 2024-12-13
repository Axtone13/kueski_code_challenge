import 'package:kueski_code_challenge/features/movies/domain/entities/movie.dart';
import 'package:kueski_code_challenge/features/movies/domain/repositories/movies_repository.dart';

class GetPopularMoviesUseCase {
  final MoviesRepository repository;

  GetPopularMoviesUseCase({required this.repository});

  Future<List<Movie>> call() {
    return repository.getPopularMovies();
  }
}
