import 'package:flutter/material.dart';
import 'package:midterm_01/screens/add_car_screen.dart';
import 'package:midterm_01/screens/car_details_screen.dart';
import 'package:midterm_01/screens/edit_car_screen.dart';
import 'package:midterm_01/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cars App',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        CarDetailsScreen.routeName: (ctx) => CarDetailsScreen(),
        AddCarScreen.routeName: (ctx) => AddCarScreen(),
        EditCarScreen.routeName: (ctx) => EditCarScreen(),
      },
    );
  }
}
