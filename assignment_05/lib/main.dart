import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_05/logic/cubits/todo_data/todo_data_cubit.dart';
import 'package:assignment_05/logic/cubits/user_data/user_data_cubit.dart';
import 'package:assignment_05/presentation/router/app_router.dart';
import 'package:assignment_05/utility/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDataCubit>(
          create: (context) => UserDataCubit(),
        ),
        BlocProvider<TodoDataCubit>(
          create: (context) => TodoDataCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter REST API',
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
