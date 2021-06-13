class Todo {
  String? id;
  String? topic;
  String? task;
  String? description;

  Todo({this.id, this.topic, this.task, this.description});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    task = json['task'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['task'] = this.task;
    data['description'] = this.description;
    return data;
  }
}
