class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final List<int> genreIds;
  final String releaseDate;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.releaseDate,
  });
}
