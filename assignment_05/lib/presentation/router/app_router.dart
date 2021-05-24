import 'package:assignment_05/presentation/screens/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:assignment_05/presentation/screens/home_screen.dart';
import 'package:assignment_05/presentation/screens/todo_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (_) => HomeScreen());
    } else if (settings.name == '/todo-screen') {
      var userID = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => TodoScreen(userID: userID));
    } else if (settings.name == '/todos/add') {
      var userID = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => AddTodoScreen(userID: userID));
    } else {
      return null;
    }
  }
}
