abstract class GenresEvent {}

class LoadGenres extends GenresEvent {
  final String lang;

  LoadGenres({required this.lang});
}