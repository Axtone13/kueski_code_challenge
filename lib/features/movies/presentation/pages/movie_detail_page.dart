import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_app_challenge/features/movies/data/models/genre_model.dart';
import 'package:movies_app_challenge/features/movies/domain/entities/movie.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_state.dart';
import 'package:movies_app_challenge/features/movies/presentation/widgets/poster.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Poster(movie: movie),
              const SizedBox(height: 16),
              Text(
                movie.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('${localizations.releaseDate}: ${movie.releaseDate}'),
              const SizedBox(height: 8),
              Text('${localizations.genres}: ${movie.genreIds.join(', ')}'),
              const SizedBox(height: 16),
              Text(
                movie.overview,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
