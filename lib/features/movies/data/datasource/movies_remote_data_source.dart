import 'package:kueski_code_challenge/features/movies/data/models/movie_model.dart';
import 'package:dio/dio.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final Dio dio = Dio();
  
  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=es-MX&page=1&sort_by=popularity.desc');

    return response.data['results'];
  }
}
