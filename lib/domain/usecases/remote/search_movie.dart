import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/remote/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  FutureEither<List<Movie>> call(String query, int page) async {
    return await repository.searchMovies(query, page);
  }
}
