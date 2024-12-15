import 'package:flutter/material.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';

class Poster extends StatelessWidget {
  const Poster({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        fit: BoxFit.cover,
        
      ),
    );
  }
}