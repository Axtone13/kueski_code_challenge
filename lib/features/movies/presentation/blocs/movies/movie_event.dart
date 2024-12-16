abstract class MovieEvent {}

class LoadMovies extends MovieEvent {
  final String lang;
  final int page;

  LoadMovies({required this.lang, required this.page});
}
