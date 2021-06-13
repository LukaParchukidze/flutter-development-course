import 'package:midterm_02/data/models/todo.dart';
import 'package:midterm_02/presentation/screens/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:midterm_02/presentation/screens/edit_todo_screen.dart';
import 'package:midterm_02/presentation/screens/home_screen.dart';
import 'package:midterm_02/presentation/screens/login_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/todos') {
      final userID = settings.arguments as String;

      return MaterialPageRoute(builder: (_) => HomeScreen(userID: userID));
    } else if (settings.name == '/login') {
      return MaterialPageRoute(builder: (_) => LoginScreen());
    } else if (settings.name == '/todos/add') {
      return MaterialPageRoute(builder: (_) => AddTodoScreen());
    } else if (settings.name == '/todos/edit') {
      final todo = settings.arguments as Todo;

      return MaterialPageRoute(builder: (_) => EditTodoScreen(todo: todo));
    } else {
      return null;
    }
  }
}
