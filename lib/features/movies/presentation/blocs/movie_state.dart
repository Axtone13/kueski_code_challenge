
import 'package:kueski_code_challenge/features/movies/domain/entities/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieListLoaded extends MovieState {
  final List<Movie> movies;

  MovieListLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
