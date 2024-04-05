import 'package:equatable/equatable.dart';
import 'package:movies_app/data/models/movie_model.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final bool isAdult;
  final List<int> genreIds;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.isAdult,
    required this.genreIds,
  });

  MovieModel toModel() {
    return MovieModel(
      id: id,
      title: title,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isAdult: isAdult,
      posterPath: posterPath,
      overview: overview,
      genreIds: genreIds,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        releaseDate,
        voteAverage,
        voteCount,
        isAdult,
        genreIds,
      ];
}
