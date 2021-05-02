import 'package:flutter/material.dart';

class CarListItem extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String model;
  final int year;

  const CarListItem({
    Key? key,
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: FadeInImage(
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/images/car_placeholder.webp"),
                image: NetworkImage(imageUrl),
              ),
            ),
            Text('$brand $model'),
            Text('$year'),
          ],
        ),
      ),
    );
  }
}
