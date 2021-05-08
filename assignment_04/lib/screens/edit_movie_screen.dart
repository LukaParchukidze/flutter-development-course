import 'package:assignment_04/data/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment_04/data/models/movie_model.dart';
import 'package:provider/provider.dart';

class EditMovieScreen extends StatefulWidget {
  static const String routeName = "/edit";

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController movieID;
  late TextEditingController movieName;
  late TextEditingController movieDescription;
  late TextEditingController movieRating;
  late TextEditingController movieReleaseDate;
  late TextEditingController movieCategory;
  late TextEditingController movieUrl;

  @override
  Widget build(BuildContext context) {
    final Map parsedData = ModalRoute.of(context)!.settings.arguments as Map;
    final Movie movie = parsedData["movie"];
    final int index = parsedData["index"];

    movieID = TextEditingController(text: movie.id.toString());
    movieName = TextEditingController(text: movie.name);
    movieDescription = TextEditingController(text: movie.description);
    movieRating = TextEditingController(text: movie.rating.toString());
    movieReleaseDate =
        TextEditingController(text: movie.releaseDate.toString());
    movieCategory = TextEditingController(text: movie.category);
    movieUrl = TextEditingController(text: movie.imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: TextFormField(
                    controller: movieRating,
                    decoration:
                        InputDecoration(hintText: "Please enter rating"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid rating";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: movieID,
                    decoration: InputDecoration(hintText: "Please enter ID"),
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid ID";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: movieName,
                    decoration: InputDecoration(hintText: "Please enter name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid name";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: movieDescription,
                    decoration:
                        InputDecoration(hintText: "Please enter description"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid description";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: movieReleaseDate,
                    decoration: InputDecoration(hintText: "Please enter year"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid release year";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: movieCategory,
                    decoration:
                        InputDecoration(hintText: "Please enter category"),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          (value != "RecentlyAdded" &&
                              value != "MyFavorites")) {
                        return "Please enter valid category";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: movieUrl,
                    decoration:
                        InputDecoration(hintText: "Please enter Image Url"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Image Url";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("BACK"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Movie movie = Movie(
                            id: int.parse(movieID.text),
                            name: movieName.text,
                            description: movieDescription.text,
                            rating: double.parse(movieRating.text),
                            releaseDate: int.parse(movieReleaseDate.text),
                            category: movieCategory.text,
                            imageUrl: movieUrl.text,
                          );
                          Provider.of<MoviesModel>(context, listen: false)
                              .editMovie(movie, index);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("EDIT"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
