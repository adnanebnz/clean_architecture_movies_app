import 'package:movies_app/data/models/movie_model.dart';

abstract class MoviesLocalDataSource {
  Future<List<MovieModel>> getFavMovies();
  Future<List<MovieModel>> getToWatchMovies();
  Future<List<MovieModel>> searchFavMovies(String query);
  Future<void> addFavMovie(MovieModel movie);
  Future<void> addWatchMovie(MovieModel movie);
  Future<void> removeFavMovie(MovieModel movie);
  Future<void> removeWatchMovie(MovieModel movie);
}
