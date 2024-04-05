import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/repositories/local/local_movie_repository.dart';

class SearchFavMovies {
  final LocalMovieRepository localRepository;

  SearchFavMovies(this.localRepository);

  FutureEither<void> call(String query) async {
    return await localRepository.searchFavMovies(query);
  }
}
