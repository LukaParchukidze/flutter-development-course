import 'package:assignment_04/data/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment_04/screens/add_movie_screen.dart';
import 'package:assignment_04/screens/movie_details_screen.dart';
import 'package:assignment_04/screens/edit_movie_screen.dart';
import 'package:assignment_04/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MoviesModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen(),
          AddMovieScreen.routeName: (ctx) => AddMovieScreen(),
          EditMovieScreen.routeName: (ctx) => EditMovieScreen(),
        },
      ),
    );
  }
}
