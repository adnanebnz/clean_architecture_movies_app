import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/core/utils/filter_params.dart';
import 'package:movies_app/domain/entities/movie.dart';

abstract class MovieRepository {
  FutureEither<List<Movie>> getTrendingMovies(int page);
  FutureEither<List<Movie>> searchMovies(String query, int page);
  FutureEither<List<Movie>> getPopularMovies(int page);
  FutureEither<List<Movie>> discoverMovies(int page,FilterParams filterParams);
}
