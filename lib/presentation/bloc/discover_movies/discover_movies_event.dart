part of 'discover_movies_bloc.dart';

sealed class DiscoverMoviesEvent extends Equatable {
  const DiscoverMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchDiscoverMovies extends DiscoverMoviesEvent {
  final FilterParams filterParams;

  const FetchDiscoverMovies(this.filterParams);

  @override
  List<Object> get props => [filterParams];
}

class FetchNextPage extends DiscoverMoviesEvent {
  final int pageKey;
  final FilterParams filterParams;

  const FetchNextPage(this.pageKey, this.filterParams);

  @override
  List<Object> get props => [pageKey, filterParams];
}
