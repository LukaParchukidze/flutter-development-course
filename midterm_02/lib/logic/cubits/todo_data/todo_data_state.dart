part of 'todo_data_cubit.dart';

abstract class TodoDataState extends Equatable {
  const TodoDataState();
}

class TodoDataInitial extends TodoDataState {
  @override
  List<Object> get props => [];
}

class TodoDataLoaded extends TodoDataState {
  final List<Todo> todoList;

  TodoDataLoaded({required this.todoList});

  @override
  List<Object?> get props => [todoList];
}

class TodoDataError extends TodoDataState {
  final String message;

  TodoDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
