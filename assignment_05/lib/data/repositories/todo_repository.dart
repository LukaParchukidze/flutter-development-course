import 'package:dio/dio.dart';
import 'package:assignment_05/data/models/todo.dart';

class TodoRepository {
  List<Todo>? todoList = [];
  Dio dio = Dio();

  Future<List<Todo>>? fetchTodoByUserID(String userID) async {
    var response = await dio
        .get('https://jsonplaceholder.typicode.com/users/$userID/todos');
    if (response.statusCode == 200) {
      var loadedTodos = <Todo>[];
      response.data.forEach((todo) {
        var todoModel = Todo.fromJson(todo);
        loadedTodos.add(todoModel);
        todoList = loadedTodos;
        return todoList!;
      });
    }
    return todoList!;
  }

  Future<void>? deleteTodoByTodoID(String todoID) async {
    await dio.delete('https://jsonplaceholder.typicode.com/posts/$todoID');
  }

  Future<void>? addTodoByTodo(Map<String, dynamic> todoData) async {
    await dio.post(
      'https://jsonplaceholder.typicode.com/posts',
      data: {
        'userId': todoData['userId'],
        'title': todoData['title'],
      },
    );
  }
}
