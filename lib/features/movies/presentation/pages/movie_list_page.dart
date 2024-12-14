import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/language/language_bloc.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/language/language_event.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/movie_bloc.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/movie_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'movie_detail_page.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.movieListTitle),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (locale) {
              context.read<LanguageBloc>().add(ChangeLanguage(locale));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: Locale('es'),
                child: Text('Español'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieListLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movie: movie),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
