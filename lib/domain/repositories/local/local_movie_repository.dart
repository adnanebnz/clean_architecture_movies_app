import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/movie.dart';

abstract class LocalMovieRepository {
  FutureEither<List<Movie>> getFavMovies(int page);
  FutureEither<List<Movie>> searchFavMovies(String query);
  FutureEither<List<Movie>> getToWatchMovies(int page);
  // TODO ADD SEARCH TO WATCH MOVIES
  FutureEither<void> addFavMovie(Movie movie);
  FutureEither<void> addWatchMovie(Movie movie);
  FutureEither<void> removeFavMovie(Movie movie);
  FutureEither<void> removeWatchMovie(Movie movie);
}
