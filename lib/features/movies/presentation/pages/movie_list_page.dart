import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/language/language_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/language/language_event.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_event.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  String _currentLanguage = 'es-MX';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      context
          .read<MovieBloc>()
          .add(LoadMovies(lang: _currentLanguage, page: _currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.movieListTitle),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) {
              _currentLanguage = locale.languageCode;
              _currentPage = 1;
              context.read<LanguageBloc>().add(ChangeLanguage(locale));
              context
                  .read<MovieBloc>()
                  .add(LoadMovies(lang: _currentLanguage, page: _currentPage));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Locale('en'),
                child: Text('🇺🇸 English'),
              ),
              const PopupMenuItem(
                value: Locale('es'),
                child: Text('🇲🇽 Español'),
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
              controller: _scrollController,
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
