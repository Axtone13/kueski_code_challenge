import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {
  MovieLoading(List<Movie> oldMovies);
}

class MovieListLoaded extends MovieState {
  final List<Movie> movies;

  MovieListLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
