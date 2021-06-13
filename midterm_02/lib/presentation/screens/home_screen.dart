import 'package:midterm_02/data/models/todo.dart';
import 'package:midterm_02/logic/cubits/todo_data/todo_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/presentation/screens/add_todo_screen.dart';
import 'package:midterm_02/presentation/screens/edit_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/todos";

  final String userID;

  const HomeScreen({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: BlocConsumer<TodoDataCubit, TodoDataState>(
        listener: (context, state) {
          if (state is TodoDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoDataInitial) {
            BlocProvider.of<TodoDataCubit>(context).getTodoData();

            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoDataLoaded) {
            return ListView.builder(
              itemCount: state.todoList.length,
              itemBuilder: (context, index) {
                var todo = state.todoList[index];
                return Dismissible(
                  key: Key(index.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    BlocProvider.of<TodoDataCubit>(context).deleteTodoData(
                      todo,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${todo.task} dismissed'),
                      ),
                    );
                  },
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete'),
                          content: Text('Remove todo ${todo.task}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.task),
                    title: Text(todo.task!),
                    subtitle: Text(todo.topic!),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Description'),
                            content: Text(todo.description!),
                          );
                        },
                      );
                    },
                    onLongPress: () {
                      Navigator.pushNamed(
                        context,
                        EditTodoScreen.routeName,
                        arguments: todo,
                      ).then(
                        (todo) => BlocProvider.of<TodoDataCubit>(context)
                            .updateTodoData(
                          Todo.fromJson(
                            todo as Map<String, dynamic>,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Ops! Something went wrong!'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AddTodoScreen.routeName,
        ).then(
          (todo) => BlocProvider.of<TodoDataCubit>(context)
              .addTodoData(todo as Map<String, dynamic>),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
