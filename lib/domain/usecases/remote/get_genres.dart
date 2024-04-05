import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/genre.dart';
import 'package:movies_app/domain/repositories/remote/genre_repository.dart';

class GetGenres {
  final GenreRepository repository;

  GetGenres(this.repository);

  FutureEither<List<Genre>> call() async {
    return await repository.getGenres();
  }
}
