import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/data/datasources/local/movies_local_data_source.dart';
import 'package:movies_app/data/models/movie_model.dart';

class MovieslocalDataSourceImpl implements MoviesLocalDataSource {
  final Box<MovieModel> box;

  MovieslocalDataSourceImpl({required this.box});

  @override
  Future<void> addFavMovie(MovieModel movie) async {
    try {
      await box.add(movie);
    } catch (e) {
      log(e.toString());
      throw Failure(message: 'Failed to add movie to favorites: $e');
    }
  }

  @override
  Future<void> addWatchMovie(MovieModel movie) async {
    try {
      await box.add(movie);
    } catch (e) {
      log(e.toString());
      throw Failure(message: 'Failed to add movie to watchlist: $e');
    }
  }

  @override
  Future<List<MovieModel>> getFavMovies() async {
    try {
      return box.values.toList();
    } catch (e) {
      throw Failure(message: 'Failed to get favorite movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getToWatchMovies() async {
    try {
      return box.values.toList();
    } catch (e) {
      throw Failure(message: 'Failed to get movies to watch: $e');
    }
  }

  @override
  Future<void> removeFavMovie(MovieModel movie) async {
    try {
      final index = box.values.toList().indexWhere((m) => m.id == movie.id);
      log("index is $index");
      if (index != -1) {
        await box.deleteAt(index);
      }
      // final movieToDelete =
      //     box.values.firstWhere((item) => item.id == movie.id);
      // log("gonna delete ${movieToDelete.title}");
      // box.delete(movieToDelete);
    } catch (e) {
      throw Failure(message: 'Failed to remove favorite movie: $e');
    }
  }

  @override
  Future<void> removeWatchMovie(MovieModel movie) async {
    try {
      final movieToDelete =
          box.values.firstWhere((item) => item.id == movie.id);
      await box.delete(movieToDelete);
    } catch (e) {
      throw Failure(message: 'Failed to remove movie to watch: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchFavMovies(String query) async {
    try {
      return box.values.where((movie) => movie.title.contains(query)).toList();
    } catch (e) {
      throw Failure(message: 'Failed to search favorite movies: $e');
    }
  }
}
