class Expense {
  String? id;
  String? title;
  String? amount;
  String? date;

  Expense({this.id, this.title, this.amount, this.date});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['date'] = this.date;
    return data;
  }
}
