import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/domain/entities/genre.dart';

abstract class GenreRepository {
  FutureEither<List<Genre>> getGenres();
}
