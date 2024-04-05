import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/local/local_movie_repository.dart';

class RemoveToWatchMovie {
  final LocalMovieRepository localRepository;

  RemoveToWatchMovie(this.localRepository);

  FutureEither<void> call(Movie movie) async {
    return await localRepository.removeWatchMovie(movie);
  }
}
