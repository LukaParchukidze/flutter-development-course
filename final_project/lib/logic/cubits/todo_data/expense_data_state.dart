part of 'expense_data_cubit.dart';

abstract class ExpenseDataState extends Equatable {
  const ExpenseDataState();
}

class ExpenseDataInitial extends ExpenseDataState {
  @override
  List<Object> get props => [];
}

class ExpenseDataLoaded extends ExpenseDataState {
  final List<Expense> expenseList;

  ExpenseDataLoaded({required this.expenseList});

  @override
  List<Object?> get props => [expenseList];
}

class ExpenseDataError extends ExpenseDataState {
  final String message;

  ExpenseDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
