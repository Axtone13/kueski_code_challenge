import 'package:kueski_code_challenge/core/utils/env_var.dart';
import 'package:kueski_code_challenge/features/movies/data/models/movie_model.dart';
import 'package:dio/dio.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies(String lang, int page);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<List<MovieModel>> getPopularMovies(String lang, int page) async {
    final response =
        await dio.get('https://api.themoviedb.org/3/discover/movie',
            queryParameters: {
              'include_adult': false,
              'include_video': false,
              'language': lang,
              'page': page,
              'sort_by': 'popularity.desc'
            },
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${Env.bearerToken}",
            }));
    final List<dynamic> results = response.data['results'];
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
