import 'package:movies_app_challenge/features/movies/domain/entities/genre.dart';
import 'package:movies_app_challenge/features/movies/domain/repositories/genres_repository.dart';

class GetGenresUseCase {
  final GenresRepository repository;

  GetGenresUseCase({required this.repository});

  Future<List<Genre>> call(String lang) {
    return repository.getMovieGenres(lang);
  }
}
