import 'package:get_storage/get_storage.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/data/datasources/local/movies_local_data_source.dart';
import 'package:movies_app/data/models/movie_model.dart';

class MovieslocalDataSourceImpl implements MoviesLocalDataSource {
  final GetStorage box;

  MovieslocalDataSourceImpl({required this.box});
  // TODO INJECT DEPENDENCY

  @override
  Future<void> addFavMovie(MovieModel movie) async {
    try {
      List favMovies = box.read('favMovies') ?? [];
      favMovies.add(movie.toJson());
      await box.write('favMovies', favMovies);
    } catch (e) {
      throw Failure(message: 'Failed to add movie to favorites: $e');
    }
  }

  @override
  Future<void> addWatchMovie(MovieModel movie) async {
    try {
      List watchMovies = box.read('watchMovies') ?? [];
      watchMovies.add(movie.toJson());
      await box.write('watchMovies', watchMovies);
    } catch (e) {
      throw Failure(message: 'Failed to add movie to watch: $e');
    }
  }

  @override
  Future<List<MovieModel>> getFavMovies(int page) async {
    try {
      List favMovies = box.read('favMovies') ?? [];
      return favMovies.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Failure(message: 'Failed to get favorite movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getToWatchMovies(int page) async {
    try {
      List watchMovies = box.read('watchMovies') ?? [];
      return watchMovies.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Failure(message: 'Failed to get movies to watch: $e');
    }
  }

  @override
  Future<void> removeFavMovie(MovieModel movie) async {
    try {
      List favMovies = box.read('favMovies') ?? [];
      favMovies.removeWhere((item) => item['id'] == movie.id);
      await box.write('favMovies', favMovies);
    } catch (e) {
      throw Failure(message: 'Failed to remove favorite movie: $e');
    }
  }

  @override
  Future<void> removeWatchMovie(MovieModel movie) async {
    try {
      List watchMovies = box.read('watchMovies') ?? [];
      watchMovies.removeWhere((item) => item['id'] == movie.id);
      await box.write('watchMovies', watchMovies);
    } catch (e) {
      throw Failure(message: 'Failed to remove movie to watch: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchFavMovies(String query) async {
    try {
      List favMovies = box.read('favMovies') ?? [];
      return favMovies
          .map((movie) => MovieModel.fromJson(movie))
          .where((movie) => movie.title.contains(query))
          .toList();
    } catch (e) {
      throw Failure(message: 'Failed to search favorite movies: $e');
    }
  }
}
