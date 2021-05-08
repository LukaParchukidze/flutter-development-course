import 'package:assignment_04/data/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment_04/screens/add_movie_screen.dart';
import 'package:assignment_04/screens/movie_details_screen.dart';
import 'package:assignment_04/screens/edit_movie_screen.dart';
import 'package:assignment_04/widgets/movie_list_item.dart';
import 'package:provider/provider.dart';

import '../data/models/movies_model.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              TextButton(
                onPressed: () {
                  Provider.of<MoviesModel>(context, listen: false)
                      .getRecentlyAdded();
                },
                child: Text('Recently Added'),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Provider.of<MoviesModel>(context, listen: false)
                      .getMyFavorites();
                },
                child: Text('My Favorites'),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Provider.of<MoviesModel>(context, listen: false).reset();
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<MoviesModel>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.filteredMovies.length,
            itemBuilder: (context, index) {
              var movie = value.filteredMovies[index];

              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Remove Movie'),
                        content: Text('Would you like to remove this movie?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<MoviesModel>(context, listen: false)
                                  .removeMovie(movie.id);

                              Navigator.pop(context);
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    }),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.routeName,
                      arguments: movie,
                    );
                  },
                  onLongPress: () {
                    Navigator.pushNamed(
                      context,
                      EditMovieScreen.routeName,
                      arguments: {
                        'movie': movie,
                        'index': index,
                      },
                    );
                  },
                  child: MovieListItem(
                    imageUrl: movie.imageUrl,
                    title: movie.name,
                    releaseDate: movie.releaseDate.toString(),
                    rating: movie.rating.toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddMovieScreen.routeName,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
