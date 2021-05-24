import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:assignment_05/data/models/todo.dart';
import 'package:assignment_05/data/repositories/todo_repository.dart';

part 'todo_data_state.dart';

class TodoDataCubit extends Cubit<TodoDataState> {
  TodoDataCubit() : super(TodoDataInitial());

  final todoRepo = TodoRepository();

  Future<void> getTodoData(String userID) async {
    emit(TodoDataInitial());

    try {
      var list = await todoRepo.fetchTodoByUserID(userID);
      emit(TodoDataLoaded(todoList: list!));
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }

  Future<void> deleteTodoData(String todoID) async {
    final list = (state as TodoDataLoaded).todoList;

    emit(TodoDataInitial());

    try {
      await todoRepo.deleteTodoByTodoID(todoID);

      list.removeAt(int.parse(todoID));

      emit(TodoDataLoaded(todoList: list));
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }

  Future<void> addTodoData(Map<String, dynamic> todoData) async {
    final list = (state as TodoDataLoaded).todoList;

    emit(TodoDataInitial());

    try {
      await todoRepo.addTodoByTodo(todoData);

      list.add(
        Todo(
          id: list.last.id! + 1,
          userId: int.parse(todoData['userId']),
          title: todoData['title'],
          completed: false,
        ),
      );

      emit(TodoDataLoaded(todoList: list));
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }
}
