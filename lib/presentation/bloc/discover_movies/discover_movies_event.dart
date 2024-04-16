part of 'discover_movies_bloc.dart';

sealed class DiscoverMoviesEvent extends Equatable {
  const DiscoverMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchDiscoverMovies extends DiscoverMoviesEvent {}

class FetchNextPage extends DiscoverMoviesEvent {
  final int pageKey;

  const FetchNextPage(this.pageKey);
}

class FilterMovies extends DiscoverMoviesEvent {
  final List<String> queries;

  const FilterMovies(this.queries);

  @override
  List<Object> get props => [queries];
}
