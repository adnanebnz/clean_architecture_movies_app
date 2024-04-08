import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/data/models/movie_model.dart';

class HiveManager {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieModelAdapter());
  }

  static Future<Box<MovieModel>> getMoviesBox() async {
    return await Hive.openBox<MovieModel>('movies');
  }
}
