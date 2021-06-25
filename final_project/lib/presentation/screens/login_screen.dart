import 'package:final_project/data/repositories/expense_repository.dart';
import 'package:final_project/logic/cubits/todo_data/expense_data_cubit.dart';
import 'package:final_project/utility/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/presentation/screens/home_screen.dart';

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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 32,
                    child: TextFormField(
                      controller: _userID,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AppThemeColors.primaryColorLight,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      keyboardType: TextInputType.name,
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
                ),
              ),
            ),
            SizedBox(
              height: 32,
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<ExpenseDataCubit>(context).emit(
                      ExpenseDataInitial(),
                    );

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomeScreen.routeName,
                      (route) => false,
                      arguments: _userID.text,
                    );

                    BlocProvider.of<ExpenseDataCubit>(context).expenseRepo =
                        ExpenseRepository(userID: _userID.text);
                  }
                },
                child: Text(
                  "Login".toUpperCase(),
                  style: TextStyle(
                    color: AppThemeColors.secondaryColorDark,
                  ),
                ),
              ),
            ),
          ],
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
