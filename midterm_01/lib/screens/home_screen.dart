import 'package:flutter/material.dart';
import 'package:midterm_01/data/models/dummy_data.dart';
import 'package:midterm_01/screens/add_car_screen.dart';
import 'package:midterm_01/screens/car_details_screen.dart';
import 'package:midterm_01/screens/edit_car_screen.dart';
import 'package:midterm_01/widgets/car_list_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddCarScreen.routeName,
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          var car = cars[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                CarDetailsScreen.routeName,
                arguments: car,
              ).then((_) => setState(() {}));
            },
            onLongPress: () {
              Navigator.pushNamed(
                context,
                EditCarScreen.routeName,
                arguments: {
                  'car': car,
                  'index': index,
                },
              ).then((_) => setState(() {}));
            },
            child: CarListItem(
              imageUrl: car.imageUrl,
              brand: car.brand,
              model: car.model,
              year: car.year,
            ),
          );
        },
      ),
    );
  }
}
