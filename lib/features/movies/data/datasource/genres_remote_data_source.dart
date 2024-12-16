import 'package:movies_app_challenge/core/utils/env_var.dart';
import 'package:movies_app_challenge/features/movies/data/models/genre_model.dart';
import 'package:dio/dio.dart';

abstract class GenresRemoteDataSource {
  Future<List<GenreModel>> getMovieGenres(String lang);
}

class GenresRemoteDataSourceImpl implements GenresRemoteDataSource {
  final Dio dio = Dio();
  
  @override
  Future<List<GenreModel>> getMovieGenres(String lang) async {
    final response = await dio.get('https://api.themoviedb.org/3/genre/movie/list',
        queryParameters: {
          'language': lang,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Env.bearerToken}",
        }));
    final List<dynamic> genres = response.data['genres'];
    return genres.map((genre) => GenreModel.fromJson(genre)).toList();
  }
  
}
