import 'package:assignment_06/presentation/screens/people_screen.dart';
import 'package:assignment_06/presentation/screens/planet_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (_) => PeopleScreen());
    } else if (settings.name == '/planet-screen') {
      var path = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => PlanetScreen(path: path));
    } else {
      return null;
    }
  }
}
