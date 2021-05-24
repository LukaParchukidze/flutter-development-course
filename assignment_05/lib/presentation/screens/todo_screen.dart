import 'package:assignment_05/presentation/screens/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_05/logic/cubits/todo_data/todo_data_cubit.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      index.toString(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${todo.title} dismissed'),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('${todo.title!}'),
                    trailing: Icon(todo.completed! ? Icons.done : Icons.close),
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
          arguments: userID,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
