import 'package:flutter/material.dart';
import 'package:midterm_02/data/models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  static const String routeName = '/todos/edit';

  final Todo todo;

  EditTodoScreen({required this.todo});

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _topic;
  late TextEditingController _task;
  late TextEditingController _description;

  @override
  void initState() {
    _topic = TextEditingController(text: widget.todo.topic);
    _task = TextEditingController(text: widget.todo.task);
    _description = TextEditingController(text: widget.todo.description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
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
                    controller: _task,
                    decoration: InputDecoration(hintText: "Please enter task"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid task";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: _topic,
                    decoration: InputDecoration(hintText: "Please enter topic"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid topic";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: _description,
                    decoration:
                        InputDecoration(hintText: "Please enter description"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid description";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("BACK"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            'id': widget.todo.id,
                            'topic': _topic.text,
                            'task': _task.text,
                            'description': _description.text,
                          });
                        }
                      },
                      child: Text("EDIT"),
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
    _topic.dispose();
    _task.dispose();
    _description.dispose();

    super.dispose();
  }
}
