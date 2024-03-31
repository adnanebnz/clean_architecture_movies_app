import 'package:movies_app/data/models/genre_model.dart';

abstract class GenresRemoteDataSource {
  Future<List<GenreModel>> getGenres();
}
