import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  static const String routeName = '/todos/add';

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _topic;
  late TextEditingController _task;
  late TextEditingController _description;

  @override
  void initState() {
    _topic = TextEditingController();
    _task = TextEditingController();
    _description = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
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
                            'topic': _topic.text,
                            'task': _task.text,
                            'description': _description.text,
                          });
                        }
                      },
                      child: Text("CREATE"),
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
