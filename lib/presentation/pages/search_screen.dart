import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_event.dart';
import 'package:movies_app/presentation/pages/single_movie_screen.dart';
import 'package:movies_app/presentation/widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<SearchMoviesBloc>()
          .add(FetchNextPage(searchController.text, pageKey, pageKey + 1));
    });
    searchController.addListener(() {
      EasyDebounce.debounce(
          'search', const Duration(milliseconds: 800), _onSearchChanged);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final text = searchController.text;
    if (text.isEmpty || !searchFocusNode.hasFocus) {
      BlocProvider.of<SearchMoviesBloc>(context).add(ResetSearchMovies());
      _pagingController.refresh();
    } else {
      BlocProvider.of<SearchMoviesBloc>(context).add(FetchSearchMovies(text));
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoTextField(
              padding: EdgeInsets.all(16),
              autocorrect: true,
              cursorColor: Colors.white,
              controller: searchController,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                builder: (context, state) {
                  if (state is SearchMoviesLoaded) {
                    _pagingController.appendPage(
                        state.movies, state.nextPageKey);
                  } else if (state is SearchMoviesError) {
                    _pagingController.error = state.message;
                  }
                  return PagedGridView<int, Movie>(
                    showNewPageProgressIndicatorAsGridChild: false,
                    showNoMoreItemsIndicatorAsGridChild: true,
                    pagingController: _pagingController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<Movie>(
                        animateTransitions: true,
                        firstPageProgressIndicatorBuilder: (context) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
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
          ],
        ),
      ),
    );
  }
}
