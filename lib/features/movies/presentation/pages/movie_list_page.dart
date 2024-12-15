import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/language/language_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/language/language_event.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_event.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movie_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_app_challenge/features/movies/presentation/widgets/movie_list.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  String _currentLanguageCode = 'en-US';
  String _currentLocaleCode = 'en';

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
          .add(LoadMovies(lang: _currentLanguageCode, page: _currentPage));
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
              final languageCode =
                  locale.languageCode == 'en' ? 'en-US' : 'es-MX';
              final localeCode = locale.languageCode == 'en' ? 'en' : 'es';
              _currentLanguageCode = languageCode;
              _currentLocaleCode = localeCode;
              _currentPage = 1;
              context.read<LanguageBloc>().add(ChangeLanguage(locale));
              // context
              //     .read<MovieBloc>()
              //     .add(LoadGenres(lang: _currentLocaleCode));
              context.read<MovieBloc>().add(
                  LoadMovies(lang: _currentLanguageCode, page: _currentPage));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text('🇺🇸 English'),
              ),
              const PopupMenuItem(
                value: Locale('es', 'MX'),
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
            return MovieList(
              movies: state.movies,
              scrollController: _scrollController,
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
