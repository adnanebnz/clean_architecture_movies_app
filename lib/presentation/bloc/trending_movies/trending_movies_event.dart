import 'package:equatable/equatable.dart';

sealed class TrendingMoviesEvent extends Equatable {
  const TrendingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchTrendingMovies extends TrendingMoviesEvent {}

class FetchNextPage extends TrendingMoviesEvent {
  final int pageKey;
  final int nextPageKey;

  const FetchNextPage(this.pageKey, this.nextPageKey);

  @override
  List<Object> get props => [pageKey, nextPageKey];
}
