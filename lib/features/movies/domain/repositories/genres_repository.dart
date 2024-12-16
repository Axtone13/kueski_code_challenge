import 'package:movies_app_challenge/features/movies/domain/entities/genre.dart';

abstract class GenresRepository {
  Future<List<Genre>> getMovieGenres(String lang);
}
