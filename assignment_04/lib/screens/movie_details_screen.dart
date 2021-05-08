import 'package:flutter/material.dart';
import 'package:assignment_04/data/models/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: FadeInImage(
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/images/image_placeholder.jpg"),
                image: NetworkImage(movie.imageUrl),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: '),
                  Text('Category: '),
                  Text('Rating: '),
                  Text('Year: '),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.name),
                  Text(movie.category),
                  Text(movie.rating.toString()),
                  Text(movie.releaseDate.toString()),
                ],
              ),
            ]),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 3,
              child: Center(
                  child: Text(
                movie.description,
                textAlign: TextAlign.center,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
