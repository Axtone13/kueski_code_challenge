import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app_challenge/features/movies/data/datasource/genres_remote_data_source.dart';
import 'package:movies_app_challenge/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movies_app_challenge/features/movies/data/repositories/genre_repository_impl.dart';
import 'package:movies_app_challenge/features/movies/domain/use_cases/get_movie_genres.dart';
import 'package:movies_app_challenge/features/movies/domain/use_cases/get_popular_movies.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/genres/genres_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/genres/genres_event.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/language/language_bloc.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/language/language_state.dart';
import 'package:movies_app_challenge/features/movies/presentation/blocs/movies/movie_event.dart';
import 'features/movies/presentation/pages/movie_list_page.dart';
import 'features/movies/presentation/blocs/movies/movie_bloc.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  // Dependency injection
  final moviesRemoteDataSource = MoviesRemoteDataSourceImpl();
  final movieRepository = MovieRepositoryImpl(moviesRemoteDataSource: moviesRemoteDataSource);
  final getMovies = GetPopularMoviesUseCase(repository: movieRepository);

  final genresRemoteDataSource = GenresRemoteDataSourceImpl();
  final genreRepository = GenreRepositoryImpl(genresRemoteDataSource: genresRemoteDataSource);
  final getGenres = GetGenresUseCase(repository: genreRepository);

  runApp(MoviesApp(getMovies: getMovies, getGenres: getGenres));
}

class MoviesApp extends StatelessWidget {
  final GetPopularMoviesUseCase getMovies;
  final GetGenresUseCase getGenres;

  const MoviesApp(
      {super.key, required this.getMovies, required this.getGenres});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Bloc provider for load genres 
        BlocProvider<GenresBloc>(
          create: (_) => GenresBloc(getGenres)
            ..add(LoadGenres(lang: 'en'))
        ),
        // Bloc provider for load movies
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(getMovies)
            ..add(LoadMovies(lang: 'en-US', page: 1)),
        ),
        // Bloc provider for change language
        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc(),
        ),
      ],
      // Bloc builder for change language and load app
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies App Challenge',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MovieListPage(),
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('es', 'MX'),
            ],
          );
        },
      ),
    );
  }
}
