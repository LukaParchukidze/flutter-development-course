import 'package:flutter/material.dart';
import 'package:final_project/presentation/screens/home_screen.dart';
import 'package:final_project/presentation/screens/login_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/expenses') {
      final userID = settings.arguments as String;

      return MaterialPageRoute(builder: (_) => HomeScreen(userID: userID));
    } else if (settings.name == '/login') {
      return MaterialPageRoute(builder: (_) => LoginScreen());
    } else {
      return null;
    }
  }
}
