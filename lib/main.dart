import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kueski_code_challenge/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:kueski_code_challenge/features/movies/domain/use_cases/get_popular_movies.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/language/language_bloc.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/language/language_state.dart';
import 'package:kueski_code_challenge/features/movies/presentation/blocs/movie_event.dart';
import 'features/movies/presentation/pages/movie_list_page.dart';
import 'features/movies/presentation/blocs/movie_bloc.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:dio/dio.dart';

void main() {
  // final dio = Dio();
  final moviesRemoteDataSource = MoviesRemoteDataSourceImpl();
  final movieRepository =
      MovieRepositoryImpl(moviesRemoteDataSource: moviesRemoteDataSource);
  final getMovies = GetPopularMoviesUseCase(repository: movieRepository);

  runApp(MyApp(getMovies: getMovies));
}

class MyApp extends StatelessWidget {
  final GetPopularMoviesUseCase getMovies;

  MyApp({required this.getMovies});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(getMovies)..add(LoadMovies()),
        ),
        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc(),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Kueski Code Challenge',
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
              Locale('en', ''),
              Locale('es', ''),
            ],
          );
        },
      ),
    );
  }
}
