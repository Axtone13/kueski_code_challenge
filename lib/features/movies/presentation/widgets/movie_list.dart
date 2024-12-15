import 'package:flutter/material.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';
import 'package:movies_app_challenge/features/movies/presentation/widgets/movie_list_item.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;

  const MovieList({
    super.key,
    required this.movies,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieListItem(movie: movie);
      },
    );
  }
}
