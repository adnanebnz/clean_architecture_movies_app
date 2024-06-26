part of 'genres_bloc.dart';

sealed class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];
}

final class GenresInitial extends GenresState {}

final class GenresLoading extends GenresState {}

final class GenresLoaded extends GenresState {
  final List<Genre> genres;

  const GenresLoaded(this.genres);
}

final class GenresError extends GenresState {
  final String message;
  const GenresError(this.message);
}
