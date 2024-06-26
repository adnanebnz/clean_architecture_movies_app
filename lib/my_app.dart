import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/presentation/bloc/discover_movies/discover_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movies_app/presentation/bloc/local_fav_movies/local_fav_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:movies_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movies_app/presentation/pages/main_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _removeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    _removeSplashScreen();
    super.initState();
  }

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
          create: (context) => getIt<LocalFavMoviesBloc>(),
        ),
        BlocProvider(create: (context) => getIt<MovieTrailerBloc>()),
        BlocProvider(create: (context) => getIt<DiscoverMoviesBloc>()),
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
        home: const MainScreen(),
      ),
    );
  }
}
