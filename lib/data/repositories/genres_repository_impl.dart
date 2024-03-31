import 'package:dartz/dartz.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/types/typedef.dart';
import 'package:movies_app/data/datasources/genres_remote_data_source.dart';
import 'package:movies_app/data/models/genre_model.dart';
import 'package:movies_app/domain/entities/genre.dart';
import 'package:movies_app/domain/repositories/genre_repository.dart';

class GenreRepositoryImpl implements GenreRepository {
  final GenresRemoteDataSource remoteDataSource;

  GenreRepositoryImpl({required this.remoteDataSource});

  @override
  FutureEither<List<Genre>> getGenres() async {
    try {
      final List<GenreModel> genreModels = await remoteDataSource.getGenres();
      final List<Genre> genres =
          genreModels.map((model) => model.toEntity()).toList();
      return Right(genres);
    } on Failure catch (failure) {
      return Left(Failure(message: failure.message));
    }
  }
}
