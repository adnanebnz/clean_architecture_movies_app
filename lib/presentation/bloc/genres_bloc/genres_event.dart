part of 'genres_bloc.dart';

sealed class GenresEvent extends Equatable {
  const GenresEvent();

  @override
  List<Object> get props => [];
}

final class FetchGenres extends GenresEvent {}
