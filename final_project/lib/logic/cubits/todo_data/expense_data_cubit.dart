import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/data/models/expense.dart';
import 'package:final_project/data/repositories/expense_repository.dart';

part 'expense_data_state.dart';

class ExpenseDataCubit extends Cubit<ExpenseDataState> {
  ExpenseDataCubit() : super(ExpenseDataInitial());

  ExpenseRepository? expenseRepo;

  Future<void> addExpenseData(Map<String, dynamic> expense) async {
    emit(ExpenseDataInitial());

    try {
      await expenseRepo?.create(expense);

      getExpenseData();
    } catch (e) {
      emit(ExpenseDataError(message: e.toString()));
    }
  }

  Future<void> getExpenseData() async {
    emit(ExpenseDataInitial());

    try {
      var list = await expenseRepo?.read();
      emit(ExpenseDataLoaded(expenseList: list!));
    } catch (e) {
      emit(ExpenseDataError(message: e.toString()));
    }
  }

  Future<void> updateExpenseData(Expense expense) async {
    emit(ExpenseDataInitial());

    try {
      await expenseRepo?.update(expense);

      getExpenseData();
    } catch (e) {
      emit(ExpenseDataError(message: e.toString()));
    }
  }

  Future<void> deleteExpenseData(Expense expense) async {
    emit(ExpenseDataInitial());

    try {
      await expenseRepo?.delete(expense);

      getExpenseData();
    } catch (e) {
      emit(ExpenseDataError(message: e.toString()));
    }
  }
}
