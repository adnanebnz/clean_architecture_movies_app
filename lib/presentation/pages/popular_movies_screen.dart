import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  final TextEditingController search = TextEditingController();
  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<PopularMoviesBloc>().add(FetchNextPage(pageKey));
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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Popular Movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
        backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
      ),
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoaded) {
              _pagingController.appendPage(
                  state.movies,
                  state.movies.isEmpty
                      ? null
                      : _pagingController.nextPageKey! + 1);
            } else if (state is PopularMoviesError) {
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
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
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
