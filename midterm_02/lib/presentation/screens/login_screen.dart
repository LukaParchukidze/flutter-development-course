import 'package:midterm_02/data/repositories/todo_repository.dart';
import 'package:midterm_02/logic/cubits/todo_data/todo_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: TextFormField(
                    controller: _userID,
                    decoration:
                        InputDecoration(hintText: "Please enter user ID"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid user ID";
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<TodoDataCubit>(context).emit(
                            TodoDataInitial(),
                          );

                          Navigator.pushNamed(
                            context,
                            HomeScreen.routeName,
                            arguments: _userID.text,
                          );

                          BlocProvider.of<TodoDataCubit>(context).todoRepo =
                              TodoRepository(userID: _userID.text);
                        }
                      },
                      child: Text("Log In"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userID.dispose();

    super.dispose();
  }
}
