import 'package:flutter/material.dart';
import 'package:midterm_01/data/models/car_model.dart';
import 'package:midterm_01/data/repository/car_helper.dart';

class EditCarScreen extends StatefulWidget {
  static const String routeName = "/edit";

  @override
  _EditCarScreenState createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController carID;
  late TextEditingController carBrand;
  late TextEditingController carModel;
  late TextEditingController carImageUrl;
  late TextEditingController carYear;
  late TextEditingController carDescription;

  @override
  Widget build(BuildContext context) {
    final Map parsedData = ModalRoute.of(context)!.settings.arguments as Map;
    final Car car = parsedData["car"];
    final int index = parsedData["index"];

    carID = TextEditingController(text: car.id.toString());
    carBrand = TextEditingController(text: car.brand);
    carModel = TextEditingController(text: car.model);
    carImageUrl = TextEditingController(text: car.imageUrl);
    carYear = TextEditingController(text: car.year.toString());
    carDescription = TextEditingController(text: car.description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: TextFormField(
                    controller: carImageUrl,
                    decoration:
                        InputDecoration(hintText: "Please enter Image Url"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Image Url";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: carID,
                    decoration: InputDecoration(hintText: "Please enter ID"),
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid ID";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: carBrand,
                    decoration: InputDecoration(hintText: "Please enter brand"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid brand";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: carModel,
                    decoration: InputDecoration(hintText: "Please enter model"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid model";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: carYear,
                    decoration: InputDecoration(hintText: "Please enter year"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid release year";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: carDescription,
                    decoration:
                        InputDecoration(hintText: "Please enter description"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid description";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("BACK"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Car car = Car(
                            id: int.parse(carID.text),
                            brand: carBrand.text,
                            model: carModel.text,
                            imageUrl: carImageUrl.text,
                            year: int.parse(carYear.text),
                            description: carDescription.text,
                          );
                          CarRepository().editCar(car, index);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("EDIT"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
