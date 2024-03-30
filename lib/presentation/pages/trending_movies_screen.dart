import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({super.key});

  @override
  State createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  int currentPage = 1;
  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      context.read<TrendingMoviesBloc>().add(FetchTrendingMovies());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
        builder: (context, state) {
          if (state is TrendingMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrendingMoviesLoaded) {
            return _buildMoviesGrid(state.movies);
          } else if (state is TrendingMoviesError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildMoviesGrid(List<Movie> movies) {
    return PagedGridView<int, Movie>(
      pagingController: pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1 / 1.43,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
      ),
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        itemBuilder: (context, item, index) => MovieCard(movies[index]),
      ),
    );
  }
}
