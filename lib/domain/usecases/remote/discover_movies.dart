import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/core/utils/filter_params.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/remote/movie_repository.dart';

class DiscoverMovies {
  final MovieRepository repository;

  DiscoverMovies(this.repository);

  FutureEither<List<Movie>> call(int page, FilterParams filterParams) async {
    return await repository.discoverMovies(page, filterParams);
  }
}
