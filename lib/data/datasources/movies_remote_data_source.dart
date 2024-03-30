import 'package:movies_app/data/models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getTrendingMovies(int page);
  Future<List<MovieModel>> searchMovies(String query, int page);
  Future<List<MovieModel>> getPopularMovies(int page);
}
