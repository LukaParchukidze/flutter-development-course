import 'package:assignment_04/data/models/movie_model.dart';
import 'package:flutter/foundation.dart';

class MoviesModel extends ChangeNotifier {
  List<Movie> movies = [
    Movie(
      id: 1,
      name: "Inception",
      imageUrl:
          "https://c8.alamy.com/comp/RYHBXJ/movie-poster-inception-2010-RYHBXJ.jpg",
      description:
          "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
      rating: 8.8,
      category: "RecentlyAdded",
      releaseDate: 2010,
    ),
    Movie(
      id: 3,
      name: "The Prestige",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BMjA4NDI0MTIxNF5BMl5BanBnXkFtZTYwNTM0MzY2._V1_.jpg",
      description:
          "After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.",
      rating: 8.5,
      category: "RecentlyAdded",
      releaseDate: 2006,
    ),
    Movie(
      id: 5,
      name: "The Dark Knight",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg",
      description:
          "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      rating: 9.0,
      category: "RecentlyAdded",
      releaseDate: 2008,
    ),
    Movie(
      id: 6,
      name: "Fight Club",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/f/fc/Fight_Club_poster.jpg",
      description:
          "An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.",
      rating: 8.8,
      category: "RecentlyAdded",
      releaseDate: 1993,
    ),
    Movie(
      id: 7,
      name: "Zack Snyder's Justice League",
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/S/pv-target-images/63cc50980f30d8d8982e165c2e856a7c5d9ec8be4b3af222525f18f315f19694._RI_V_TTW_.jpg",
      description:
          "Zack Snyder's definitive director's cut of Justice League. Determined to ensure Superman's ultimate sacrifice was not in vain, Bruce Wayne aligns forces with Diana Prince with plans to recruit a team of metahumans to protect the world from an approaching threat of catastrophic proportions.",
      rating: 8.5,
      category: "MyFavorites",
      releaseDate: 2021,
    ),
    Movie(
      id: 8,
      name: "WandaVision",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BYjJiZmE5ZDgtYWUxZi00MWI1LTg2MmEtZmUwZGE2YzRkNTE5XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
      description:
          "Blends the style of classic sitcoms with the MCU, in which Wanda Maximoff and Vision - two super-powered beings living their ideal suburban lives - begin to suspect that everything is not as it seems.",
      rating: 8.2,
      category: "MyFavorites",
      releaseDate: 2021,
    ),
    Movie(
      id: 9,
      name: "Avengers: Endgame",
      imageUrl:
          "https://live.staticflickr.com/65535/49460296257_31e8216abb_b.jpg",
      description:
          "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.",
      rating: 8.4,
      category: "MyFavorites",
      releaseDate: 2019,
    ),
    Movie(
      id: 10,
      name: "Soul",
      imageUrl: "https://i.ytimg.com/vi/EVB21AxR1Hw/movieposter_en.jpg",
      description:
          "After landing the gig of a lifetime, a New York jazz pianist suddenly finds himself trapped in a strange land between Earth and the afterlife.",
      rating: 8.1,
      category: "MyFavorites",
      releaseDate: 2020,
    ),
    Movie(
      id: 11,
      name: "The Queen's Gambit",
      imageUrl:
          "https://live.staticflickr.com/65535/50673553037_9f0f60709a_b.jpg",
      description:
          "Orphaned at the tender age of nine, prodigious introvert Beth Harmon discovers and masters the game of chess in 1960s USA. But child stardom comes at a price.",
      rating: 8.6,
      category: "MyFavorites",
      releaseDate: 2020,
    ),
    Movie(
      id: 2,
      name: "The Shawshank Redemption",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY1200_CR89,0,630,1200_AL_.jpg",
      description:
          "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
      rating: 9.3,
      category: "RecentlyAdded",
      releaseDate: 1994,
    ),
  ];

  late List<Movie> filteredMovies;

  MoviesModel() {
    filteredMovies = List.from(movies);
  }

  addMovie(Movie movie) {
    movies.add(movie);

    if (filteredMovies.first.category == movie.category) {
      filteredMovies.add(movie);
    }

    notifyListeners();
  }

  editMovie(Movie movie, int index) {
    filteredMovies[index] = movie;

    movies[movies.indexOf(
        movies.firstWhere((element) => element.id == movie.id))] = movie;

    notifyListeners();
  }

  removeMovie(int id) {
    filteredMovies.removeWhere((element) => element.id == id);
    movies.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  getRecentlyAdded() {
    filteredMovies =
        movies.where((element) => element.category == "RecentlyAdded").toList();

    notifyListeners();
  }

  getMyFavorites() {
    filteredMovies =
        movies.where((element) => element.category == "MyFavorites").toList();

    notifyListeners();
  }

  reset() {
    filteredMovies = movies;

    notifyListeners();
  }
}
