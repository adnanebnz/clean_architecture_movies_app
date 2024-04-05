import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/remote/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;

  GetTrendingMovies(this.repository);

  FutureEither<List<Movie>> call(int page) async {
    return await repository.getTrendingMovies(page);
  }
}
