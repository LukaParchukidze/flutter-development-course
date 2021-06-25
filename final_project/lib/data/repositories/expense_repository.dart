import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:final_project/data/models/expense.dart';

class ExpenseRepository {
  Dio dio = Dio();

  final String userID;

  final CollectionReference<Map<String, dynamic>> expenses;

  ExpenseRepository({required this.userID})
      : expenses = FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('expenses');

  Future<void> create(Map<String, dynamic> expense) async {
    await expenses
        .add(expense)
        .whenComplete(() => print('Created $expense!'))
        .catchError((error) => throw Exception(error));
  }

  Future<List<Expense>> read() async {
    return await expenses
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Expense.fromJson({'id': doc.id, ...doc.data()}))
            .toList())
        .whenComplete(() => print('Read expenses!'))
        .catchError((error) => throw Exception(error));
  }

  Future<void> update(Expense expense) async {
    await expenses
        .doc(expense.id)
        .update(expense.toJson())
        .whenComplete(() => print('Updated $expense!'))
        .catchError((error) => throw Exception(error));
  }

  Future<void> delete(Expense expense) async {
    await expenses
        .doc(expense.id)
        .delete()
        .whenComplete(() => print('Deleted $expense!'))
        .catchError((error) => throw Exception(error));
  }
}
