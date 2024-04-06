import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/presentation/bloc/delete_local_fav_movies/delete_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/get_local_fav_movies/get_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/save_local_fav_movies/save_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_local_fav_movies/search_local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/pages/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TrendingMoviesBloc>()..add(FetchTrendingMovies()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<PopularMoviesBloc>()..add(FetchPopularMovies()),
        ),
        BlocProvider(
          create: (context) => getIt<GenresBloc>()..add(FetchGenres()),
        ),
        BlocProvider(
          create: (context) => getIt<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SaveLocalFavMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SearchLocalFavMoviesBloc>(),
        ),
        BlocProvider(
            create: (context) =>
                getIt<GetLocalFavMoviesBloc>()..add(FetchFavMovies())),
        BlocProvider(
          create: (context) => getIt<DeleteLocalFavMoviesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Lato",
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.white,
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(23, 23, 23, 1),
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white, brightness: Brightness.dark),
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: const TextStyle(color: Colors.white),
            contentPadding: const EdgeInsets.all(15),
            isDense: false,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.white.withAlpha(100),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.white.withAlpha(100),
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.white.withAlpha(100),
                width: 1,
              ),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
