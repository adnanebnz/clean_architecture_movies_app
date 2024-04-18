// ignore_for_file: non_constant_identifier_names

class FilterParams {
  final String? sortBy;
  final double? voteAverageGte;
  final double? voteCountGte;
  final String? release_date_gte;
  final String? release_date_lte;
  final double? vote_average_lte;
  final double? vote_average_gte;
  final double? vote_count_lte;
  final double? vote_count_gte;
  final List<int>? with_genres;
  final int? year;

  FilterParams({
    this.sortBy,
    this.voteAverageGte,
    this.voteCountGte,
    this.release_date_gte,
    this.release_date_lte,
    this.vote_average_lte,
    this.vote_average_gte,
    this.vote_count_lte,
    this.vote_count_gte,
    this.with_genres,
    this.year,
  });
}
