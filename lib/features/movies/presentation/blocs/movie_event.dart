abstract class MovieEvent {}

class LoadMovies extends MovieEvent {
  final String lang;
  final int page;

  LoadMovies({required this.lang, required this.page});
}

class LoadGenres extends MovieEvent {
  final String lang;

  LoadGenres({required this.lang});
}