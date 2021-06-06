import 'package:assignment_06/logic/cubits/planet/planet_cubit.dart';
import 'package:assignment_06/presentation/router/app_router.dart';
import 'package:assignment_06/utility/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubits/people/people_cubit.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeopleCubit>(
          create: (context) => PeopleCubit(),
        ),
        BlocProvider<PlanetCubit>(
          create: (context) => PlanetCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Assignment 06',
        onGenerateRoute: AppRouter().onGenerateRoute,
        theme: ThemeData.dark(),
      ),
    );
  }
}
