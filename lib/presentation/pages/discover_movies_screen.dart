import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/core/utils/filter_params.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/discover_movies/discover_movies_bloc.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/filter_dialog.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class DiscoverMoviesScreen extends StatefulWidget {
  const DiscoverMoviesScreen({super.key});

  @override
  State createState() => _DiscoverMoviesScreenState();
}

class _DiscoverMoviesScreenState extends State<DiscoverMoviesScreen> {
  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );

  late FilterParams filterParams;

  @override
  void initState() {
    filterParams = FilterParams();
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<DiscoverMoviesBloc>()
          .add(FetchNextPage(pageKey, filterParams));
    });
    super.initState();
  }

  void _submitFilters() {
    _pagingController.refresh();
    context.read<DiscoverMoviesBloc>().add(FetchDiscoverMovies(filterParams));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Discover Movies',
            style: TextStyle(
              fontSize: 20,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              filterParams = (await showDialog<FilterParams>(
                context: context,
                builder: (context) => FilterDialog(initialParams: filterParams),
              ))!;
              _submitFilters();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: BlocBuilder<DiscoverMoviesBloc, DiscoverMoviesState>(
          builder: (context, state) {
            if (state is DiscoverMoviesLoaded) {
              _pagingController.appendPage(
                  state.movies,
                  state.movies.isEmpty
                      ? null
                      : _pagingController.nextPageKey! + 1);
            } else if (state is DiscoverMoviesError) {
              _pagingController.error = state.message;
            }
            return PagedGridView<int, Movie>(
              showNewPageProgressIndicatorAsGridChild: false,
              showNoMoreItemsIndicatorAsGridChild: true,
              pagingController: _pagingController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
              ),
              builderDelegate: PagedChildBuilderDelegate<Movie>(
                  animateTransitions: true,
                  firstPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  itemBuilder: (context, item, index) => MovieCard(
                        item,
                        () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SingleMovieScreen(
                              movie: item,
                            ),
                          ));
                        },
                      )),
            );
          },
        ),
      ),
    );
  }
}
