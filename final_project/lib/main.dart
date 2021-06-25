import 'package:final_project/utility/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/logic/cubits/todo_data/expense_data_cubit.dart';
import 'package:final_project/presentation/router/app_router.dart';
import 'package:final_project/presentation/screens/login_screen.dart';
import 'package:final_project/utility/app_bloc_observer.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseDataCubit>(
          create: (context) => ExpenseDataCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: AppThemeColors.backgroundColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle().copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                AppThemeColors.primaryColorLight,
              ),
            ),
          ),
        ),
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
