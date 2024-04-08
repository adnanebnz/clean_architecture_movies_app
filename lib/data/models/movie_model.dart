import 'package:hive/hive.dart';
import 'package:movies_app/domain/entities/movie.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  String? overview = '';
  @HiveField(3)
  String? posterPath = '';
  @HiveField(4)
  final String releaseDate;
  @HiveField(5)
  final double voteAverage;
  @HiveField(6)
  final int voteCount;
  @HiveField(7)
  final bool isAdult;
  @HiveField(8)
  final List<int>? genreIds;

  MovieModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.genreIds,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.isAdult,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      isAdult: json['adult'],
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((item) => item as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview ?? '',
      'poster_path': posterPath ?? '',
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': isAdult,
      'genre_ids': genreIds,
    };
  }

  // Convert Movie toEntity
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isAdult: isAdult,
      genreIds: genreIds ?? [],
    );
  }
}
