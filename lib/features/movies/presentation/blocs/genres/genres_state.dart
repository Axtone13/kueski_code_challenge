import 'package:movies_app_challenge/features/movies/domain/entities/genre.dart';

abstract class GenresState {}

class GenreInitial extends GenresState {}

class GenreLoading extends GenresState {}

class GenreListLoaded extends GenresState {
  final List<Genre> genres;

  GenreListLoaded(this.genres);
}

class GenreError extends GenresState {
  final String message;

  GenreError(this.message);
}