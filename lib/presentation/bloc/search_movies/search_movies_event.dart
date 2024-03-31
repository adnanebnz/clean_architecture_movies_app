abstract class SearchMoviesEvent {}

class FetchSearchMovies extends SearchMoviesEvent {
  final String query;

  FetchSearchMovies(this.query);
}

class FetchNextPage extends SearchMoviesEvent {
  final String query;
  final int pageKey;
  FetchNextPage(this.query, this.pageKey);
}
