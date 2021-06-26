import 'dart:ui';

import 'package:final_project/data/models/expense.dart';
import 'package:final_project/logic/cubits/todo_data/expense_data_cubit.dart';
import 'package:final_project/utility/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/expenses";

  final String userID;

  const HomeScreen({Key? key, required this.userID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExpenseDataCubit, ExpenseDataState>(
        listener: (context, state) {
          if (state is ExpenseDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is ExpenseDataInitial) {
            BlocProvider.of<ExpenseDataCubit>(context).getExpenseData();

            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpenseDataLoaded) {
            _controller.forward();

            return Stack(
              children: [
                Image.asset('assets/images/background.png'),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 48.0,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TweenAnimationBuilder(
                              curve: Curves.easeInOut,
                              tween: Tween<double>(begin: 0, end: 24),
                              duration: Duration(seconds: 1),
                              builder: (context, double value, child) {
                                return Text(
                                  'Personal Expenses',
                                  style: TextStyle(
                                    fontSize: value,
                                    color: AppThemeColors.secondaryColorDark,
                                  ),
                                );
                              },
                            ),
                            MaterialButton(
                              padding: EdgeInsets.all(0),
                              color: AppThemeColors.primaryColorDark,
                              shape: CircleBorder(),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return AddExpenseBottomSheet();
                                  },
                                );
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 175,
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 48,
                            ),
                            child: Text(
                              '${state.expenseList.fold<double>(0, (previousValue, element) => previousValue + double.parse(element.amount!))} \$',
                              style: TextStyle(
                                color: AppThemeColors.secondaryColorDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0.0, 1.5),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Curves.easeInOutCubic,
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: state.expenseList.length,
                            itemBuilder: (context, index) {
                              var expense = state.expenseList[index];

                              return Card(
                                elevation: 4,
                                child: ListTile(
                                  title: Text(expense.title!),
                                  subtitle: Text(expense.date!),
                                  trailing: Text('${expense.amount} \$'),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ExpenseBottomSheet(
                                            expense: expense);
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Ops! Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}

class AddExpenseBottomSheet extends StatefulWidget {
  @override
  _AddExpenseBottomSheetState createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amount = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _date = TextEditingController(text: 'Pick Date');

  @override
  void dispose() {
    _amount.dispose();
    _title.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Container(
        color: AppThemeColors.primaryColorAccent,
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _amount,
                      decoration: InputDecoration(
                        hintText: 'Please enter expense amount',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return "Please enter valid expense amount";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _title,
                      decoration: InputDecoration(
                        hintText: 'Please enter expense title',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid expense title";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_date.text),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                _date.text = value
                                    .toString()
                                    .substring(0, 10)
                                    .split('-')
                                    .reversed
                                    .join('/');

                                setState(() {});
                              }
                            });
                          },
                          child: Text('Pick Date'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppThemeColors.primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppThemeColors.primaryColorDark,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ExpenseDataCubit>(context)
                                .addExpenseData(
                              {
                                'amount': _amount.text,
                                'title': _title.text,
                                'date': _date.text != 'Pick Date'
                                    ? _date.text
                                    : DateTime.now()
                                        .toString()
                                        .substring(0, 10)
                                        .split('-')
                                        .reversed
                                        .join('/'),
                              },
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Add".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenseBottomSheet extends StatelessWidget {
  final Expense expense;

  const ExpenseBottomSheet({required this.expense});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Container(
        color: AppThemeColors.primaryColorAccent,
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Column(
            children: [
              Text(
                expense.title!,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expense Amount'),
                  Text('${expense.amount!} \$'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date:'),
                  Text(expense.date!),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: AppThemeColors.primaryColorDark,
                      shape: CircleBorder(),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return EditExpenseBottomSheet(expense: expense);
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: AppThemeColors.primaryColorDark,
                      shape: CircleBorder(),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete'),
                              content: Text('Remove ${expense.title}?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);

                                    BlocProvider.of<ExpenseDataCubit>(context)
                                        .deleteExpenseData(
                                      expense,
                                    );

                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('${expense.title} deleted'),
                                      ),
                                    );
                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditExpenseBottomSheet extends StatefulWidget {
  final Expense expense;

  const EditExpenseBottomSheet({required this.expense});

  @override
  _EditExpenseBottomSheetState createState() => _EditExpenseBottomSheetState();
}

class _EditExpenseBottomSheetState extends State<EditExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _amount;
  late final TextEditingController _title;
  late final TextEditingController _date;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController(text: widget.expense.amount);
    _title = TextEditingController(text: widget.expense.title);
    _date = TextEditingController(text: widget.expense.date);
  }

  @override
  void dispose() {
    _amount.dispose();
    _title.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Container(
        color: AppThemeColors.primaryColorAccent,
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      controller: _amount,
                      decoration: InputDecoration(
                        hintText: 'Please enter expense amount',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return "Please enter valid expense amount";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      controller: _title,
                      decoration: InputDecoration(
                        hintText: 'Please enter expense title',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid expense title";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_date.text),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                _date.text = value
                                    .toString()
                                    .substring(0, 10)
                                    .split('-')
                                    .reversed
                                    .join('/');

                                setState(() {});
                              }
                            });
                          },
                          child: Text('Pick Date'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppThemeColors.primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppThemeColors.primaryColorDark,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ExpenseDataCubit>(context)
                                .updateExpenseData(
                              Expense.fromJson(
                                {
                                  'id': widget.expense.id,
                                  'amount': _amount.text,
                                  'title': _title.text,
                                  'date': _date.text != 'Pick Date'
                                      ? _date.text
                                      : DateTime.now()
                                          .toString()
                                          .substring(0, 10)
                                          .split('-')
                                          .reversed
                                          .join('/'),
                                },
                              ),
                            );

                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Edit".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
