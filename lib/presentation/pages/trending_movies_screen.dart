import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_state.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({super.key});

  @override
  State createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  final TextEditingController search = TextEditingController();
  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<TrendingMoviesBloc>()
          .add(FetchNextPage(pageKey, pageKey + 1));
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
        builder: (context, state) {
          if (state is TrendingMoviesLoaded) {
            _pagingController.appendPage(state.movies, state.nextPageKey);
          } else if (state is TrendingMoviesError) {
            _pagingController.error = state.message;
          }
          return PagedGridView<int, Movie>(
            showNewPageProgressIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: true,
            pagingController: _pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<Movie>(
                animateTransitions: true,
                firstPageProgressIndicatorBuilder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
                newPageProgressIndicatorBuilder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
                itemBuilder: (context, item, index) => MovieCard(item)),
          );
        },
      ),
    );
  }
}
