import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final bool isAdult;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.isAdult,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        releaseDate,
        voteAverage,
        voteCount,
        isAdult
      ];
}
