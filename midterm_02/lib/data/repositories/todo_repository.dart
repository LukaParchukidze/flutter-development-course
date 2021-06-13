import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:midterm_02/data/models/todo.dart';

class TodoRepository {
  Dio dio = Dio();

  final String userID;

  final CollectionReference<Map<String, dynamic>> todos;

  TodoRepository({required this.userID})
      : todos = FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('todos');

  Future<void> create(Map<String, dynamic> todo) async {
    await todos
        .add(todo)
        .whenComplete(() => print('Created $todo!'))
        .catchError((error) => throw Exception(error));
  }

  Future<List<Todo>> read() async {
    return await todos
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Todo.fromJson({'id': doc.id, ...doc.data()}))
            .toList())
        .whenComplete(() => print('Read todos!'))
        .catchError((error) => throw Exception(error));
  }

  Future<void> update(Todo todo) async {
    await todos
        .doc(todo.id)
        .update(todo.toJson())
        .whenComplete(() => print('Updated $todo!'))
        .catchError((error) => throw Exception(error));
  }

  Future<void> delete(Todo todo) async {
    await todos
        .doc(todo.id)
        .delete()
        .whenComplete(() => print('Deleted $todo!'))
        .catchError((error) => throw Exception(error));
  }
}
