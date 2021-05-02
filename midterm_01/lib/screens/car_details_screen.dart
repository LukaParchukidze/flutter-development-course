import 'package:flutter/material.dart';
import 'package:midterm_01/data/models/car_model.dart';
import 'package:midterm_01/data/repository/car_helper.dart';

class CarDetailsScreen extends StatelessWidget {
  static const String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final Car car = ModalRoute.of(context)!.settings.arguments as Car;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Remove Car'),
                      content: Text('Would you like to remove this car?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            CarRepository().removeCar(car.id);

                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: FadeInImage(
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/images/car_placeholder.webp"),
                image: NetworkImage(car.imageUrl),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Brand: '),
                  Text('Model: '),
                  Text('Year: '),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.brand),
                  Text(car.model),
                  Text(car.year.toString()),
                ],
              ),
            ]),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 3,
              child: Center(
                  child: Text(
                car.description,
                textAlign: TextAlign.center,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
