import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/local/local_movie_repository.dart';

class GetFavMovies {
  final LocalMovieRepository localRepository;

  GetFavMovies(this.localRepository);

  FutureEither<List<Movie>> call() async {
    return await localRepository.getFavMovies();
  }
}
