import 'package:dio/dio.dart';
import 'package:movies_app/core/exceptions/Failure.dart';
import 'package:movies_app/core/exceptions/dio_exception.dart';
import 'package:movies_app/core/managers/dio_manager.dart';
import 'package:movies_app/data/datasources/remote/genres_remote_data_source.dart';
import 'package:movies_app/data/models/genre_model.dart';

class GenresRemoteDataSourceImpl implements GenresRemoteDataSource {
  var dio = DioManager.getDio();

  GenresRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await dio.get("/genre/movie/list");
      final List<GenreModel> genres = (response.data['genres'] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList();
      return genres;
    } on DioException catch (dioError) {
      final error = DioExceptions.fromDioError(dioError);
      throw Failure(message: error.message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
