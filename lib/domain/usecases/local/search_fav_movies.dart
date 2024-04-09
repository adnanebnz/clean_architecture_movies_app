import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/local/local_movie_repository.dart';

class SearchFavMovies {
  final LocalMovieRepository localRepository;

  SearchFavMovies(this.localRepository);

  FutureEither<List<Movie>> call(String query) async {
    return await localRepository.searchFavMovies(query);
  }
}
