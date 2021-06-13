import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:midterm_02/data/models/todo.dart';
import 'package:midterm_02/data/repositories/todo_repository.dart';

part 'todo_data_state.dart';

class TodoDataCubit extends Cubit<TodoDataState> {
  TodoDataCubit() : super(TodoDataInitial());

  TodoRepository? todoRepo;

  Future<void> addTodoData(Map<String, dynamic> todo) async {
    emit(TodoDataInitial());

    try {
      await todoRepo?.create(todo);

      getTodoData();
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }

  Future<void> getTodoData() async {
    emit(TodoDataInitial());

    try {
      var list = await todoRepo?.read();
      emit(TodoDataLoaded(todoList: list!));
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }

  Future<void> updateTodoData(Todo todo) async {
    emit(TodoDataInitial());

    try {
      await todoRepo?.update(todo);

      getTodoData();
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }

  Future<void> deleteTodoData(Todo todo) async {
    emit(TodoDataInitial());

    try {
      await todoRepo?.delete(todo);

      getTodoData();
    } catch (e) {
      emit(TodoDataError(message: e.toString()));
    }
  }
}
